class User < ApplicationRecord
  has_one :score, as: :objectable
  has_many :teem_user

  validates_presence_of :name

  def name_with_score_balans
    "#{name} #{score.balans} y.e."
  end

  def score_id
    score.id
  end
end
