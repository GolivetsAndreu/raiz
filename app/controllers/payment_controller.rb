class PaymentController < ApplicationController
  before_action :load_data

  def index; end

  def transaction
    @transaction = Transaction.new(t_params)
    @transaction.transfer
    render 'payment/index'
  end

  def load_data
    @collection = User.all + Team.all
    @transactions = Transaction.order(id: :desc)
  end

  private

  def t_params
    params.permit(:from_account_id, :to_account_id, :amount)
  end
end
