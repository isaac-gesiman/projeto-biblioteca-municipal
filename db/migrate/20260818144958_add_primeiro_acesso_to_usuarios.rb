class AddPrimeiroAcessoToUsuarios < ActiveRecord::Migration[8.1]
  def change
   add_column :usuarios, :primeiro_acesso, :boolean, default: true, null: false
  end
end
