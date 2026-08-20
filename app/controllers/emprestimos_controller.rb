class EmprestimosController < ApplicationController
  before_action :exigir_bibliotecario, except: [:renovar]
  before_action :exigir_usuario, only: [:renovar]
  
    def index
        @emprestimos = Emprestimo
        .includes(:usuario, :livro, :bibliotecario)
        .where(data_devolucao: nil)
        .order(data_emprestimo: :desc)
    end

  def new
    carregar_opcoes
    @emprestimo = Emprestimo.new
  end

  def create
    @emprestimo = Emprestimo.new(emprestimo_params)

    usuario = @emprestimo.usuario

    unless usuario&.authenticate_senha_emprestimo(params[:senha_emprestimo])
      carregar_opcoes
      @emprestimo.errors.add(:base, "Senha de empréstimo incorreta")
      return render :new, status: :unprocessable_content
    end

    @emprestimo.data_emprestimo = Time.current
    @emprestimo.data_prevista_devolucao = Date.current + 20.days

    if @emprestimo.save
      @emprestimo.livro.update!(disponivel: false)

      redirect_to new_emprestimo_path,
                  notice: "Empréstimo realizado com sucesso!"
    else
      carregar_opcoes
      render :new, status: :unprocessable_content
    end
  end

    def devolver
        @emprestimo = Emprestimo.find(params[:id])

        ActiveRecord::Base.transaction do
            @emprestimo.update!(
                data_devolucao: Date.current,
                status: "devolvido"
            )

            @emprestimo.livro.update!(disponivel: true)
        end

          redirect_to emprestimos_path,
                      notice: "Livro devolvido com sucesso!"
        end
        def renovar
      @emprestimo = usuario_atual.emprestimos.find(params[:id])

      if @emprestimo.data_devolucao.present?
        redirect_to painel_usuario_path,
                    alert: "Este empréstimo já foi devolvido."
        return
      end

      if @emprestimo.renovacoes >= 1
        redirect_to painel_usuario_path,
                    alert: "Este empréstimo já foi renovado."
        return
      end

      if @emprestimo.data_prevista_devolucao < Date.current
        redirect_to painel_usuario_path,
                    alert: "Empréstimos em atraso não podem ser renovados."
        return
      end

      @emprestimo.update!(
        data_prevista_devolucao:
          @emprestimo.data_prevista_devolucao + 20.days,

        renovacoes:
          @emprestimo.renovacoes + 1
      )

      redirect_to painel_usuario_path,
                  notice: "Empréstimo renovado por mais 20 dias."
    end
  private

  def carregar_opcoes
    @usuarios = Usuario.order(:nome)
    @livros = Livro.where(disponivel: true).order(:titulo)
    @bibliotecarios = Bibliotecario.order(:nome)
  end

  def emprestimo_params
    params.expect(
      emprestimo: [:usuario_id, :livro_id, :bibliotecario_id]
    )
  end
end