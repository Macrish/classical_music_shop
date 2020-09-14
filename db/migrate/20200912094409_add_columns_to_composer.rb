class AddColumnsToComposer < ActiveRecord::Migration[6.0]
  def change
    add_column :composers, :middle_name, :string, limit: 25
    add_column :composers, :birth_year, :integer
    add_column :composers, :death_year, :integer
    add_column :composers, :country, :string, limit: 3
  end
end
