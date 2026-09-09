import mysql.connector

def get_connection():
    """Cria e retorna a conexão com o banco de dados MySQL."""
    try:
        connection = mysql.connector.connect(
            host="localhost",
            port=3307,            # A porta deve ficar em um parâmetro separado
            user="root",
            password="admin",      # Sua senha do MySQL Workbench
            database="db_atividade"
        )
        return connection
    except mysql.connector.Error as err:
        print(f"Erro ao conectar ao MySQL: {err}")
        return None
    