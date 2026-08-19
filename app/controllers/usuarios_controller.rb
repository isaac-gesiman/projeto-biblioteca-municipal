class UsuariosController < ApplicationController
  before_action :exigir_bibliotecario, only: [:new, :create]
  before_action :exigir_usuario, only: [:nova_senha, :atualizar_senha, :painel]

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)

    # Senha provisória para entrar no site
    senha_login = SecureRandom.alphanumeric(12)

    @usuario.password = senha_login
    @usuario.password_confirmation = senha_login

    # Senha de 8 números para confirmar empréstimos
    senha_emprestimo = SecureRandom.random_number(100_000_000).to_s.rjust(8, "0")

    @usuario.senha_emprestimo = senha_emprestimo
    @usuario.senha_emprestimo_confirmation = senha_emprestimo

    if @usuario.save
      UsuarioMailer.senha_emprestimo(
        @usuario,
        senha_login,
        senha_emprestimo
      ).deliver_now

      redirect_to root_path, notice: "Usuário cadastrado com sucesso!"
    else
      render :new, status: :unprocessable_content
    end
  end

  def nova_senha
    @usuario = usuario_atual
  end

  def atualizar_senha
    @usuario = usuario_atual

    if @usuario.update(
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      primeiro_acesso: false
    )
      reset_session

      redirect_to login_usuario_path,
                  notice: "Senha cadastrada com sucesso! Faça login novamente."
    else
      render :nova_senha, status: :unprocessable_content
    end
  end

  def painel
    @usuario = usuario_atual

    @emprestimos = @usuario.emprestimos
                          .includes(:livro)
                          .order(data_emprestimo: :desc)
  end

  private

  def usuario_params
    params.expect(usuario: [:nome, :cpf, :telefone, :email, :idade])
  end
end