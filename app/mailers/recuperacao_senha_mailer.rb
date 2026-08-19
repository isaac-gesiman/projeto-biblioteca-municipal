class RecuperacaoSenhaMailer < ApplicationMailer
  def redefinir_senha(bibliotecario)
    @bibliotecario = bibliotecario

    @token = bibliotecario.password_reset_token

    mail(
      to: @bibliotecario.email,
      subject: "Redefinição de senha - Biblioteca Municipal"
    )
  end
end