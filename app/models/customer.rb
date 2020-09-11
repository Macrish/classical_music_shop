class Customer < ApplicationRecord
  # если клиент в БД будет удален, все orders связанные с этой записью будут тоже удалены
  has_many :orders, dependent: true,
           order: "created_at ASC"
end
