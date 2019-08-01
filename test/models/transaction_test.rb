require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "doesn't do transaction when haven't  enough money" do
    transaction = Transaction.new(from_score_id: scores(:alex_score).id, to_score_id: scores(:andreu_score).id, amount: 2000)
    transaction.transfer

    assert transaction.errors.any?
    assert transaction.errors.full_messages[0] == "From score haven't enough money"
  end

  test "doesn't do transactions with the same scores" do
    transaction = Transaction.new(from_score_id: scores(:alex_score).id, to_score_id: scores(:alex_score).id, amount: 100)
    transaction.transfer

    assert transaction.errors.any?
    assert transaction.errors.full_messages[0] == "From score cannot be equal to the incoming score"
  end

  test "doesn't do transaction if user not a teem's member" do
    transaction = Transaction.new(from_score_id: scores(:misterbandb_score).id, to_score_id: scores(:andreu_score).id, amount: 100)
    transaction.transfer

    assert transaction.errors.any?
    assert transaction.errors.full_messages[0] == "To score can't be get money from this score"
  end

  test "do transaction" do
    score_from = scores(:alex_score)
    score_to = scores(:andreu_score)

    transaction = Transaction.new(from_score_id: score_from.id, to_score_id: score_to.id, amount: 100)
    transaction.transfer

    assert !transaction.errors.any?
    assert score_from.balans + 100, score_from.reload.balans
    assert score_to.balans - 100, score_from.reload.balans
  end
end
