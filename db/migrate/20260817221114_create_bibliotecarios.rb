class CreateBibliotecarios < ActiveRecord::Migration[8.1]
  def change
    create_table :bibliotecarios do |t|
      t.string :nome, null: false
      t.string :cpf, null: false
      t.string :telefone, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :primeiro_acesso, null: false, default: true

      t.timestamps
    end

    add_index :bibliotecarios, :cpf, unique: true
    add_index :bibliotecarios, :email, unique: true
  end
end