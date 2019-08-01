class Score < ApplicationRecord
  belongs_to :objectable, polymorphic: true
  has_many :transactions

  validates_presence_of :balans, :objectable

  def self.create_transaction(score_from_id, score_to_id, amount)
    Score.transaction do
      transaction = Transaction.new(from_score_id: score_from_id, to_score_id: score_to_id, amount: amount)
      if transaction.save
        transaction.from_score.lock!
        transaction.from_score.do_transaction(amount, 'debit')
        transaction.to_score.do_transaction(amount, 'credit')
      end
      transaction
    end
  end

  def do_transaction(amount, type)
    type == 'debit' ? self.balans -= amount : self.balans += amount
    self.save
  end

  def enough_money?(amount)
    score = lock!
    score.balans >= amount
  end
end
