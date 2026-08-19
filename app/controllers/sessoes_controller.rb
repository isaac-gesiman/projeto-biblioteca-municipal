class SessoesController < ApplicationController
  def new
  end

  def create
    bibliotecario = Bibliotecario.find_by(email: params[:email])

    if bibliotecario&.authenticate(params[:password])
      reset_session
      session[:bibliotecario_id] = bibliotecario.id

      if bibliotecario.primeiro_acesso
        redirect_to nova_senha_path
      else
        redirect_to painel_bibliotecario_path
      end
    else
      flash.now[:alert] = "E-mail ou senha incorretos"
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end