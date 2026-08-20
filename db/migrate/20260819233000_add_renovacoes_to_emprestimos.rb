class AddRenovacoesToEmprestimos < ActiveRecord::Migration[8.1]
  def change
    add_column :emprestimos,
               :renovacoes,
               :integer,
               default: 0,
               null: false
  end
end