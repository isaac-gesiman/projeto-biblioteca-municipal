class RecuperacoesSenhaController < ApplicationController
  def new
  end

  def create
    bibliotecario = Bibliotecario.find_by(cpf: params[:cpf])

    if bibliotecario
      RecuperacaoSenhaMailer.redefinir_senha(bibliotecario).deliver_now
    end

    redirect_to login_path,
                notice: "Se o CPF estiver cadastrado, enviaremos um link para o e-mail registrado."
  end

  def edit
    @bibliotecario = Bibliotecario.find_by_password_reset_token(params[:token])

    unless @bibliotecario
      redirect_to esqueci_senha_path,
                  alert: "Link inválido ou expirado."
    end
  end

  def update
    @bibliotecario = Bibliotecario.find_by_password_reset_token(params[:token])

    unless @bibliotecario
      return redirect_to esqueci_senha_path,
                         alert: "Link inválido ou expirado."
    end

    if @bibliotecario.update(
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      primeiro_acesso: false
    )
      redirect_to login_path,
                  notice: "Senha alterada com sucesso! Faça login."
    else
      render :edit, status: :unprocessable_content
    end
  end
end