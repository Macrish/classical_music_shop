class CreateInstrumentsWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :instruments_works do |t|
      t.belongs_to :instrument
      t.belongs_to :work
    end
  end
end
