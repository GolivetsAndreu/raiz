class Teem < ApplicationRecord
  has_one :score, as: :objectable
  has_many :teem_user

  validates_presence_of :name

  def is_teems_user?(user_id)
    teem_user.pluck(:id).include?(user_id)
  end

  def name_with_score_balans
    "#{name} #{score.balans} y.e."
  end
end
