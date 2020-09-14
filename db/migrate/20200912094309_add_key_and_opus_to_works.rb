class AddKeyAndOpusToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :key, :string
    add_column :works, :opus, :integer
  end
end
