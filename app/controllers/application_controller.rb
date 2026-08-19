class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  stale_when_importmap_changes

  helper_method :bibliotecario_atual
  helper_method :usuario_atual

  def bibliotecario_atual
    @bibliotecario_atual ||= Bibliotecario.find_by(id: session[:bibliotecario_id])
  end

  def exigir_bibliotecario
    unless bibliotecario_atual
      redirect_to login_path,
                  alert: "Faça login para acessar esta página."
    end
  end

  def usuario_atual
    @usuario_atual ||= Usuario.find_by(id: session[:usuario_id])
  end

  def exigir_usuario
    unless usuario_atual
      redirect_to login_usuario_path,
                  alert: "Faça login para acessar esta página."
    end
  end
end