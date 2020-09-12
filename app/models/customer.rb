class Customer < ApplicationRecord
  # если клиент в БД будет удален, все orders связанные с этой записью будут тоже удалены
  # эта запись устарела
  # has_many :orders, dependent: true, order: "created_at ASC"
  has_many :orders, ->{ order("created_at ASC") }, dependent: :destroy

  def open_orders
    # orders.find(:all, :conditions => "status = 'open'")  #устареласю
    orders.where(status: 'open')
  end

  def editions_on_order
    open_orders.map { |order| order.edition }.uniq
  end

  def edition_history
    orders.map { |order| order.edition }.uniq
  end

  def works_on_order
    editions_on_order.map { |edition| edition.works }.flatten.uniq
  end

  def work_history
    edition_history.map { |edition| edition.works }.flatten.uniq
  end
end
