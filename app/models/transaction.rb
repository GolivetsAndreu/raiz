class Transaction < ApplicationRecord
  TYPES_TRANSACTION = %w[Credit Debit]

  belongs_to :from_score, foreign_key: 'from_score_id', class_name: 'Score'
  belongs_to :to_score, foreign_key: 'to_score_id', class_name: 'Score'

  validates_presence_of :from_score_id, :to_score_id, :amount
  validate :enough_money?, if: -> { from_score_id.present? }
  validate :from_score_not_same_to_score, if: -> { from_score_id.present? && to_score_id.present? }
  validate :teem_can_do_teem_user, if: -> { from_score_id.present? && to_score_id.present? }

  def enough_money?
    errors.add(:from_score_id, "haven't enough money") unless from_score.enough_money?(amount)
  end

  def from_score_not_same_to_score
    errors.add(:from_score_id, "cannot be equal to the incoming score") unless from_score_id != to_score_id
  end

  def teem_can_do_teem_user
    if from_score.objectable_type == 'Teem'
      errors.add(:to_score_id, "can't be get money from this score") unless to_score.objectable.is_teems_user?(score_to.id)
    end
  end
end
