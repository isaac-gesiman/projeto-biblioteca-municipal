# 📚 Biblioteca Municipal

Sistema web para gerenciamento de uma biblioteca, desenvolvido com **Ruby on Rails**, **PostgreSQL** e publicado no **Railway**.

O projeto permite administrar usuários, bibliotecários, livros, categorias, empréstimos e devoluções, além de possuir autenticação, recuperação de senha e envio automático de e-mails.

🌐 **Aplicação online:**  
https://projeto-biblioteca-municipal-production.up.railway.app

---

## 🖥️ Sobre o projeto

O sistema foi desenvolvido para separar o acesso em dois tipos de usuário:

### 👨‍💼 Bibliotecário

O bibliotecário possui acesso administrativo e pode:

- Cadastrar novos usuários
- Cadastrar novos bibliotecários
- Cadastrar livros
- Cadastrar categorias
- Registrar empréstimos
- Registrar devoluções
- Visualizar empréstimos ativos
- Recuperar senha por e-mail
- Realizar autenticação segura

### 👤 Leitor

O leitor possui uma área própria onde pode:

- Fazer login
- Criar uma nova senha no primeiro acesso
- Visualizar seus empréstimos
- Consultar a data prevista de devolução
- Consultar o status do empréstimo
- Encerrar sua sessão

A interface do leitor também possui suporte para **computadores e dispositivos móveis**.

---

# ✨ Principais funcionalidades

## 🔐 Autenticação

O sistema possui autenticação independente para:

- Bibliotecários
- Usuários/leitores

As senhas são armazenadas utilizando `has_secure_password`, através da gem **bcrypt**.

---

## 🔑 Primeiro acesso

Quando um usuário ou bibliotecário é cadastrado, o sistema pode gerar uma senha provisória.

No primeiro login, o usuário é direcionado para criar sua própria senha definitiva.

---

## 📧 Envio de e-mails

O sistema utiliza a **API do Brevo** para o envio de e-mails transacionais.

Os e-mails são utilizados para:

- Envio de senha provisória
- Envio da senha de empréstimo
- Recuperação de senha
- Redefinição de senha

A comunicação com o Brevo é realizada através de **HTTPS**, utilizando uma API Key armazenada como variável de ambiente.

---

## 📖 Cadastro de livros

Cada livro pode possuir informações como:

- Título
- Autor
- Categoria
- Idade mínima
- Disponibilidade
- Observações

Um livro emprestado automaticamente passa a ficar indisponível até que seja devolvido.

---

## 🗂️ Categorias

Os livros podem ser organizados por categorias.

Exemplos:

- Romance
- Ficção
- História
- Literatura
- Biografia

---

## 🔄 Empréstimos

Ao realizar um empréstimo, o sistema registra:

- Usuário
- Livro
- Bibliotecário responsável
- Data do empréstimo
- Data prevista de devolução
- Status
- Data da devolução

A previsão de devolução é calculada automaticamente pelo sistema.

---

## 🔢 Senha de empréstimo

Cada usuário possui uma senha específica de **8 dígitos** utilizada para confirmar empréstimos.

Essa senha é diferente da senha utilizada para entrar no sistema.

---

## 🎂 Controle de idade

O sistema verifica a idade do usuário antes de permitir determinados empréstimos.

Caso:

```text
idade do usuário < idade mínima do livro
