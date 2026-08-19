class Bibliotecario < ApplicationRecord
  # Relacionamentos
  has_many :emprestimos

  # Senha protegida
  has_secure_password

  # Campos obrigatórios
  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :telefone, presence: true
  validates :email, presence: true, uniqueness: true
end