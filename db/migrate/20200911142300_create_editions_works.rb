class CreateEditionsWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :editions_works do |t|
      t.belongs_to :edition
      t.belongs_to :work
    end
  end
end
