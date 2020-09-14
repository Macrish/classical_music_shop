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

  # old code version
  # def composer_rankings
  #   history = work_history.map {|ed| ed.composer }.flatten
  #   history.uniq.sort_by do |c|
  #     history.select {|comp| comp == c}.size
  #   end.reverse
  # end
  #
  # def instrument_rankings
  #   history = work_history.map {|work| work.instruments }.flatten
  #   history.uniq.sort_by do |i|
  #     history.select {|instr| instr == i}.size
  #   end.reverse
  # end

  # new code version
  # pre-flattened instrument [["cello", "piano"], ["cello", "orchestra"], ["orchestra"]]
  # cello => 2, piano => 1, orchestra => 2
  def rank(list)
    list.uniq.sort_by do |a|
      list.select {|b| b == a}.size
    end.reverse  # отобразит orchestra, cello, piano
  end

  def composer_rankings
    # flatten - ["cello","piano","cello","orchestra","orchestra"]
    rank(work_history.map {|ed| ed.composer }.flatten)
  end

  def instrument_rankings
    rank(work_history.map {|work| work.instruments }.flatten)
  end

  #этот метод показывает сколько копий edition
  # заказал заказчик
  def copies_of(edition)
    orders.where(edition_id: "#{edition.id}").size
  end

  # def balance
  #   acc = 0
  #   open_orders.each do |order|
  #     acc += order.edition.price
  #   end
  #   "%.2f" % acc
  # end

  # здесь считаем стоимость всех неоплаченных заказов клиента
  def balance
    "%.2f" % open_orders.inject(0) do |acc,order|
      acc + order.edition.price
    end
  end
end
