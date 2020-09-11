class AddYearToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :year, :integer
  end
end
