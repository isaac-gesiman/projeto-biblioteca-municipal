class Livro < ApplicationRecord
  # Relacionamentos
  belongs_to :categoria

  has_many :emprestimos
  has_many :usuarios, through: :emprestimos

  # Campos obrigatórios
  validates :titulo, presence: true
  validates :autor, presence: true

  # Idade mínima deve ser um número inteiro maior ou igual a 0
  validates :idade_minima,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  # Disponível só pode ser true ou false
  validates :disponivel, inclusion: { in: [true, false] }
end