require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "doesn't do transaction when haven't  enough money" do
    transaction = Transaction.new(from_account_id: accounts(:alex_account).id, to_account_id: accounts(:andreu_account).id, amount: 2000)
    transaction.transfer

    assert transaction.errors.any?
    assert transaction.errors.full_messages[0] == "From account haven't enough money"
  end

  test "doesn't do transactions with the same accounts" do
    transaction = Transaction.new(from_account_id: accounts(:alex_account).id, to_account_id: accounts(:alex_account).id, amount: 100)
    transaction.transfer

    assert transaction.errors.any?
    assert transaction.errors.full_messages[0] == "From account cannot be equal to the incoming account"
  end

  test "doesn't do transaction if user not a team's member" do
    transaction = Transaction.new(from_account_id: accounts(:misterbandb_account).id, to_account_id: accounts(:andreu_account).id, amount: 100)
    transaction.transfer

    assert transaction.errors.any?
    assert transaction.errors.full_messages[0] == "To account can't be get money from this account"
  end

  test "do transaction" do
    account_from = accounts(:alex_account)
    account_to = accounts(:andreu_account)

    transaction = Transaction.new(from_account_id: account_from.id, to_account_id: account_to.id, amount: 100)
    transaction.transfer

    assert !transaction.errors.any?
    assert account_from.balance + 100, account_from.reload.balance
    assert account_to.balance - 100, account_from.reload.balance
  end
end
