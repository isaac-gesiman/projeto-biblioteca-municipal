class Emprestimo < ApplicationRecord
  # Relacionamentos
  belongs_to :usuario
  belongs_to :livro
  belongs_to :bibliotecario

  # Campos obrigatórios
  validates :data_emprestimo, presence: true
  validates :data_prevista_devolucao, presence: true

  # Status permitidos
  validates :status,
            presence: true,
            inclusion: { in: ["ativo", "atrasado", "devolvido"] }

  # Regras para realizar um empréstimo
  validate :livro_deve_estar_disponivel, on: :create
  validate :usuario_deve_ter_idade_minima, on: :create

  private

  def livro_deve_estar_disponivel
    return if livro.nil?

    unless livro.disponivel?
      errors.add(:livro, "não está disponível para empréstimo")
    end
  end

  def usuario_deve_ter_idade_minima
    return if usuario.nil? || livro.nil?

    if usuario.idade < livro.idade_minima
      errors.add(
        :usuario,
        "não possui a idade mínima necessária para este livro"
      )
    end
  end

  public
  
  MULTA_POR_DIA = 1.00

  def dias_atraso
    return 0 if data_prevista_devolucao.blank?

    data_referencia =
      if data_devolucao.present?
        data_devolucao.to_date
      else
        Date.current
      end

    atraso = (data_referencia - data_prevista_devolucao.to_date).to_i

    [atraso, 0].max
  end

  def multa
    dias_atraso * MULTA_POR_DIA
  end

  def atrasado?
    dias_atraso.positive?
  end
end