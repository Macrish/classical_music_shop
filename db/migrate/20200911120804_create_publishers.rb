class CreatePublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :publishers do |t|
      t.string :name, limit: 60
      t.string :city, limit: 30
      t.string :country, limit: 3
      t.timestamps
    end
  end
end
