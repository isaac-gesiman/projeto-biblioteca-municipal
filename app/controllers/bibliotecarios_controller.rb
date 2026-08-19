class BibliotecariosController < ApplicationController
    before_action :exigir_bibliotecario, only: [:new, :create, :painel]
    def new
        @bibliotecario = Bibliotecario.new
    end

    def create
        @bibliotecario = Bibliotecario.new(bibliotecario_params)

        senha_provisoria = SecureRandom.alphanumeric(12)

        @bibliotecario.password = senha_provisoria
        @bibliotecario.password_confirmation = senha_provisoria
        @bibliotecario.primeiro_acesso = true

        if @bibliotecario.save
        BibliotecarioMailer.senha_provisoria(
            @bibliotecario,
            senha_provisoria
        ).deliver_now

        redirect_to new_bibliotecario_path,
                    notice: "Bibliotecário cadastrado com sucesso!"
        else
        render :new, status: :unprocessable_content
        end
    end

    def nova_senha
        @bibliotecario = Bibliotecario.find_by(id: session[:bibliotecario_id])

        redirect_to login_path unless @bibliotecario
    end

    def atualizar_senha
        @bibliotecario = Bibliotecario.find_by(id: session[:bibliotecario_id])

        return redirect_to login_path unless @bibliotecario

        if @bibliotecario.update(
            password: params[:password],
            password_confirmation: params[:password_confirmation],
            primeiro_acesso: false
        )
            redirect_to painel_bibliotecario_path,
                        notice: "Senha cadastrada com sucesso!"
        else
            render :nova_senha, status: :unprocessable_content
        end
    end

    def painel
    end
  private

  def bibliotecario_params
    params.expect(
      bibliotecario: [:nome, :cpf, :telefone, :email]
    )
  end
end