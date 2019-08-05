class Transaction < ApplicationRecord
  TYPES_TRANSACTION = %w[Credit Debit]

  belongs_to :from_account, foreign_key: 'from_account_id', class_name: 'Account'
  belongs_to :to_account, foreign_key: 'to_account_id', class_name: 'Account'

  validates_presence_of :from_account_id, :to_account_id, :amount, allow_blank: false
  validate :enough_money, if: -> { from_account_id.present? }
  validate :from_account_not_same_to_account, if: -> { from_account_id.present? && to_account_id.present? }
  validate :team_can_do_team_user, if: -> { from_account_id.present? && to_account_id.present? }

  def enough_money
    errors.add(:from_account_id, "haven't enough money") unless from_account.enough_money?(amount)
  end

  def from_account_not_same_to_account
    errors.add(:from_account_id, "cannot be equal to the incoming account") unless from_account_id != to_account_id
  end

  def team_can_do_team_user
    if from_account.objectable_type == 'Team'
      errors.add(:to_account_id, "can't be get money from this account") unless from_account.objectable.is_teams_user?(to_account.id)
    end
  end

  def transfer
    ActiveRecord::Base.transaction do
      if valid?
        from_account.lock!
        enough_money
        raise ActiveRecord::Rollback if errors.any?
        from_account.update!(balance: from_account.balance - amount)
        to_account.update!(balance: to_account.balance + amount)
        ActiveRecord::Base.transaction do
          save
        end
      end
    end
  end
end
