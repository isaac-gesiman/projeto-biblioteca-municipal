class CreateLivros < ActiveRecord::Migration[8.1]
  def change
    create_table :livros do |t|
      t.string :titulo, null: false
      t.string :autor, null: false

      t.references :categoria,
                   null: false,
                   foreign_key: true

      t.integer :idade_minima, null: false, default: 0

      t.boolean :disponivel, null: false, default: true

      t.text :observacoes

      t.timestamps
    end
  end
end
