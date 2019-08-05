class Account < ApplicationRecord
  belongs_to :objectable, polymorphic: true
  has_many :transactions

  validates_presence_of :balance, :objectable

  def enough_money?(amount)
    balance >= amount
  end
end
