class CategoriasController < ApplicationController
  before_action :exigir_bibliotecario
  def new
    @categoria = Categoria.new
  end

  def create
    @categoria = Categoria.new(categoria_params)

    if @categoria.save
      redirect_to new_categoria_path, notice: "Categoria cadastrada com sucesso!"
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def categoria_params
    params.expect(categoria: [:nome])
  end
end