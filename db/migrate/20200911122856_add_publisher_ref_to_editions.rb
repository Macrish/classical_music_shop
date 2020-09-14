class AddPublisherRefToEditions < ActiveRecord::Migration[6.0]
  def change
    add_reference :editions, :publisher, foreign_key: true
    add_column :editions, :title, :string, limit: 100
  end
end