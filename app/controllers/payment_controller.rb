class PaymentController < ApplicationController
  before_action :load_data

  def index; end

  def transaction
    score_from = t_params[:score_from].presence
    score_to = t_params[:score_to].presence
    amount = t_params[:amount].present? ? t_params[:amount].to_i : nil

    transaction = Score.create_transaction(score_from, score_to, amount)
    if transaction.errors.any?
      @errors = transaction.errors.full_messages
      render 'payment/errors', errors: @errors
    else
      @transaction_result = 'Transaction have done success'
      render 'payment/index', transaction_status: @transaction_result
    end
  end

  def load_data
    users = User.all
    teems = Teem.all
    @collection = users + teems
    @transactions = Transaction.order(id: :desc)
  end

  private

  def t_params
    params.permit(:score_from, :score_to, :amount)
  end
end
