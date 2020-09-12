class Composer < ApplicationRecord
  has_many :works

  def editions
    works.map {|work| work.editions }.flatten.uniq
  end

  def whole_name
    first_name + " " +
    (if middle_name then middle_name + " " else "" end) +
    last_name
  end
end
