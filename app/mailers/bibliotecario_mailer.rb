class BibliotecarioMailer < ApplicationMailer
  def senha_provisoria(bibliotecario, senha)
    @bibliotecario = bibliotecario
    @senha = senha

    mail(
      to: @bibliotecario.email,
      subject: "Acesso à Biblioteca Municipal"
    )
  end
end