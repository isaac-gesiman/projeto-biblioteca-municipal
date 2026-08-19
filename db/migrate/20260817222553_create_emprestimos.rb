class CreateEmprestimos < ActiveRecord::Migration[8.1]
  def change
    create_table :emprestimos do |t|
      t.references :usuario,
                   null: false,
                   foreign_key: true

      t.references :livro,
                   null: false,
                   foreign_key: true

      t.references :bibliotecario,
                   null: false,
                   foreign_key: true

      t.datetime :data_emprestimo, null: false

      t.date :data_prevista_devolucao, null: false

      # Fica vazio enquanto o livro ainda não foi devolvido
      t.date :data_devolucao

      # ativo / atrasado / devolvido
      t.string :status, null: false, default: "ativo"

      t.timestamps
    end

    # Um mesmo livro não pode ter dois empréstimos
    # em aberto ao mesmo tempo
    add_index :emprestimos,
              :livro_id,
              unique: true,
              where: "data_devolucao IS NULL",
              name: "index_emprestimos_livro_em_aberto"
  end
end