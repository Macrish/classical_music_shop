class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :nick, limit: 15
      t.string :password, limit: 40
      t.string :email, limit: 50

      t.timestamps
    end
  end
end
