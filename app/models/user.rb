class User < ApplicationRecord
  has_one :account, as: :objectable
  has_many :team_users

  validates_presence_of :name

  def name_with_account_balance
    "#{name} #{account.balance} y.e."
  end

  def account_id
    account.id
  end
end
