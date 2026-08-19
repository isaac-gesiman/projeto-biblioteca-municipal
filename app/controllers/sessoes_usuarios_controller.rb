class SessoesUsuariosController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by(email: params[:email])

    if usuario&.authenticate(params[:password])
      reset_session
      session[:usuario_id] = usuario.id

        if usuario.primeiro_acesso
        redirect_to nova_senha_usuario_path
        else
        redirect_to painel_usuario_path,
                    notice: "Login realizado com sucesso!"
        end
    else
      flash.now[:alert] = "E-mail ou senha incorretos"
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    reset_session
    redirect_to login_usuario_path
  end
end