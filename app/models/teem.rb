class Teem < ApplicationRecord
  has_one :account, as: :objectable
  has_many :teem_user

  validates_presence_of :name

  def is_teems_user?(user_id)
    teem_user.pluck(:id).include?(user_id)
  end

  def name_with_account_balans
    "#{name} #{account.balans} y.e."
  end

  def account_id
    account.id
  end
end
