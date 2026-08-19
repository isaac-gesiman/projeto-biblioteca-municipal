class LivrosController < ApplicationController
  before_action :exigir_bibliotecario
  def new
    @livro = Livro.new
    @categorias = Categoria.order(:nome)
  end

  def create
    @livro = Livro.new(livro_params)

    if @livro.save
      redirect_to new_livro_path, notice: "Livro cadastrado com sucesso!"
    else
      @categorias = Categoria.order(:nome)
      render :new, status: :unprocessable_content
    end
  end

  private

  def livro_params
    params.expect(
      livro: [:titulo, :autor, :categoria_id, :idade_minima, :observacoes]
    )
  end
end