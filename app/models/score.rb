class Score < ApplicationRecord
  belongs_to :objectable, polymorphic: true
  validates_presence_of :balans, :objectable

  def self.create_transaction(obj_from, obj_to, price)
    Score.transaction do
      score_from = obj_from.score.lock!
      score_to = obj_to.score.lock!
      if score_from.enough_money?(price)
        score_from.balans = score_from.balans - price
        score_to.balans = score_to.balans + price
        score_from.save
        score_to.save
      end
    end
  end

  def enough_money?(price)
    self.balans >= price
  end
end
