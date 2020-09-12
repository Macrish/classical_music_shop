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

  # 2.4 ml
  def editions
    works.map {|work| work.editions }.flatten.uniq
  end

  #0.5 ml
  # def editions
  #   Edition.find_by_sql("SELECT edition_id from editions_works
  #   LEFT JOIN works ON editions_works.work_id = works.id
  #   LEFT JOIN composers ON works.composer_id = composers.id
  #   WHERE (composers.id = #{id})")
  # end

  def publishers
    editions.map{|edition| edition.publisher }.uniq
  end
end
