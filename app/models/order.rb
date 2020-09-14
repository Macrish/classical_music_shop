class Order < ApplicationRecord
  before_create :self_status

  belongs_to :customer
  belongs_to :edition

  def self_status
    #self необходимо, чтобы  анализатор Ruby интерпретировал
    # status как вызов метода, а не как локальную переменную
    self.status = "open"
  end
end
