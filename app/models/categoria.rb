class Categoria < ApplicationRecord
  # Relacionamentos
  has_many :livros

  # Campos obrigatórios
  validates :nome, presence: true, uniqueness: true
end