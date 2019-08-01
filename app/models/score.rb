class Score < ApplicationRecord
  belongs_to :objectable, polymorphic: true
  has_many :transactions

  validates_presence_of :balans, :objectable

  def enough_money?(amount)
    balans >= amount
  end
end
