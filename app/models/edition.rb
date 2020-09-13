class Edition < ApplicationRecord
  before_create :self_description

  belongs_to :publisher
  has_and_belongs_to_many :works
  has_many :orders

  def self_description
    self.description = 'standard' unless description
  end

  def nice_title
    # "Title (Tanya Lee, 2020)"
    (title || works[0].nice_title) + " (#{publisher.name}, #{year})"
  end

  def century
    # if 2020
    # не правильный суффикс для 3 века
    c = (year - 1).to_s[0,2].succ
    c += case c
    when "21" then "st"
    else "th"
    end
    c + " century"
  end
end
