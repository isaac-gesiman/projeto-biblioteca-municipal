class Usuario < ApplicationRecord
  # Relacionamentos
  has_many :emprestimos
  has_many :livros, through: :emprestimos

  # Senha de login do usuário
  has_secure_password

  # Senha de empréstimo protegida
  has_secure_password :senha_emprestimo

  # Campos obrigatórios
  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :telefone, presence: true
  validates :email, presence: true, uniqueness: true
  validates :idade, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 0
                    }
end