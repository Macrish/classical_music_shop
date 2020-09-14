class CreateInstruments < ActiveRecord::Migration[6.0]
  def change
    create_table :instruments do |t|
      t.string :name, limit: 20
      t.string :family, limit: 15

      t.timestamps
    end
  end
end
