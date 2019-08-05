class Team < ApplicationRecord
  has_one :account, as: :objectable
  has_many :team_users

  validates_presence_of :name

  def is_teams_user?(user_id)
    team_users.pluck(:id).include?(user_id)
  end

  def name_with_account_balance
    "#{name} #{account.balance} y.e."
  end

  def account_id
    account.id
  end
end
