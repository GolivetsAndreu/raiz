class PaymentController < ApplicationController
  before_action :load_data

  def index; end

  def transaction
    transaction = Transaction.new(t_params)
    transaction.transfer
    render 'payment/index', errors: @errors = transaction.errors
  end

  def load_data
    users = User.all
    teems = Teem.all
    @collection = users + teems
    @transactions = Transaction.order(id: :desc)
  end

  private

  def t_params
    params.permit(:from_score_id, :to_score_id, :amount)
  end
end
