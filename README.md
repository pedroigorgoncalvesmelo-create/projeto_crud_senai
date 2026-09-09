# Sistema de Gestão - Projeto CRUD SENAI

Projeto desenvolvido para a avaliação prática do SENAI. É uma aplicação web completa para gerenciamento de dados com cadastro, leitura, edição e remoção (CRUD), além de relatórios e validações.

## O que foi usado?

* **Python** com **Flask** (Back-end)
* **MySQL** na porta 3307 (Banco de Dados)
* **HTML5, CSS3 e Bootstrap 5** (Front-end)

## O que tem nas pastas?

* `app.py`: Onde ficam as rotas e a lógica principal da aplicação.
* `database.py`: Faz a conexão do Python com o MySQL.
* `MySql.sql`: Script para criar o banco e as tabelas com dados de teste.
* `requirements.txt`: Bibliotecas necessárias para rodar o projeto.
* `templates/`: Telas e componentes do sistema (`index.html`, `relatorio.html`, etc.).

## Tabelas do Banco de Dados

O banco organiza as seguintes informações:
* `cidades`
* `departamentos`
* `clientes`
* `fornecedores`
* `funcionarios` (ligado com cidades e departamentos)

## 💻 Como rodar na sua máquina

1. Baixe o repositório:
   ```bash
   git clone [https://github.com/pedroigorgoncalvesmelo-create/projeto_crud_senai.git](https://github.com/pedroigorgoncalvesmelo-create/projeto_crud_senai.git)
