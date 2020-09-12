class ModifyPublishers < ActiveRecord::Migration[6.0]
  def change
    add_column :publishers, :price, :integer
    remove_column :publishers, :country, :string
  end
end
