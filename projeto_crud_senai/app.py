from flask import Flask, render_template, request, redirect, url_for, flash
from database import get_connection
import mysql.connector

app = Flask(__name__)
app.secret_key = 'chave_secreta_senai'

# ROUTE: Página Inicial
@app.route('/')
def index():
    return render_template('index.html')

# ROUTE: Listar e Cadastrar Cidades
@app.route('/cidades', methods=['GET', 'POST'])
def cidades():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['nome']
        estado = request.form['estado']
        cursor.execute("INSERT INTO cidades (nome, estado) VALUES (%s, %s)", (nome, estado))
        conn.commit()
        flash('Cidade cadastrada com sucesso!', 'success')
        return redirect(url_for('cidades'))

    cursor.execute("SELECT * FROM cidades")
    lista_cidades = cursor.fetchall()
    conn.close()
    return render_template('cidades.html', cidades=lista_cidades)

# ROUTE: Excluir Cidade com Tratamento de Erro (Integridade Referencial)
@app.route('/cidades/delete/<int:id>')
def delete_cidade(id):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM cidades WHERE id_cidade = %s", (id,))
        conn.commit()
        flash('Cidade excluída com sucesso!', 'success')
    except mysql.connector.Error as err:
        # Trata o erro de Chave Estrangeira se a cidade tiver vínculos
        flash('Erro: Não é possível excluir uma cidade vinculada a clientes ou funcionários!', 'danger')
    finally:
        conn.close()
    return redirect(url_for('cidades'))

# ROUTE: Listar e Cadastrar Funcionários (com validação de CPF)
@app.route('/funcionarios', methods=['GET', 'POST'])
def funcionarios():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['nome']
        cpf = request.form['cpf']
        cargo = request.form['cargo']
        salario = request.form['salario']
        id_departamento = request.form['id_departamento']
        id_cidade = request.form['id_cidade']

        # Validação de CPF Duplicado
        cursor.execute("SELECT * FROM funcionarios WHERE cpf = %s", (cpf,))
        if cursor.fetchone():
            flash('Erro: Já existe um funcionário cadastrado com este CPF!', 'danger')
        else:
            cursor.execute("""
                INSERT INTO funcionarios (nome, cpf, cargo, salario, id_departamento, id_cidade)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (nome, cpf, cargo, salario, id_departamento, id_cidade))
            conn.commit()
            flash('Funcionário cadastrado com sucesso!', 'success')
        return redirect(url_for('funcionarios'))

    cursor.execute("SELECT * FROM funcionarios")
    lista_funcionarios = cursor.fetchall()

    cursor.execute("SELECT * FROM cidades")
    lista_cidades = cursor.fetchall()

    cursor.execute("SELECT * FROM departamentos")
    lista_departamentos = cursor.fetchall()

    conn.close()
    return render_template('funcionarios.html', funcionarios=lista_funcionarios, cidades=lista_cidades, departamentos=lista_departamentos)

# ROUTE: Relatório com INNER JOIN
@app.route('/relatorio')
def relatorio():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    
    # Junção de tabelas conforme exigido
    query = """
        SELECT f.nome AS funcionario, f.cargo, f.salario, 
               c.nome AS cidade, d.nome AS departamento
        FROM funcionarios f
        INNER JOIN cidades c ON f.id_cidade = c.id_cidade
        INNER JOIN departamentos d ON f.id_departamento = d.id_departamento
    """
    cursor.execute(query)
    dados = cursor.fetchall()
    conn.close()
    return render_template('relatorio.html', dados=dados)

if __name__ == '__main__':
    app.run(debug=True)