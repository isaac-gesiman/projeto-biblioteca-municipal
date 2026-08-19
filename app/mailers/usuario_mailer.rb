class UsuarioMailer < ApplicationMailer
  def senha_emprestimo(usuario, senha_login, senha_emprestimo)
    @usuario = usuario
    @senha_login = senha_login
    @senha_emprestimo = senha_emprestimo

    mail(
      to: @usuario.email,
      subject: "Acesso à Biblioteca Municipal"
    )
  end
end