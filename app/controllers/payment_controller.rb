class PaymentController < ApplicationController
  before_action :load_data

  def index; end

  def transaction
    @errors = validate_params_for_transaction(t_params)
    if @errors.any?
      render 'payment/errors', errors: @errors
    else
      obj_from = t_params[:user_from].present? ? User.find(t_params[:user_from]) : Teem.find(t_params[:teem_from])
      obj_to = t_params[:user_to].present? ? User.find(t_params[:user_to]) : Teem.find(t_params[:teem_to])
      type_obj_from = t_params[:user_from].present? ? 'user' : 'teem'
      price = t_params[:price].to_i

      @transaction_result = create_transaction(obj_from, obj_to, type_obj_from, price) ? 'Transaction have done success' : 'Haven`t enough money'
      render 'payment/index', transaction_status: @transaction_result
    end
  end

  def create_transaction(obj_from, obj_to, type_obj_from, price)
    if type_obj_from == 'user' || obj_from.is_teems_user?(obj_to)
      if Score.create_transaction(obj_from, obj_to, price)
        create_transaction_history(obj_from, obj_to, price)
      end
    end
  end

  def create_transaction_history(obj_from, obj_to, price)
    DebitTransaction.create(score_id: obj_from.score.id, price: price, name: obj_from.name)
    CreditTransaction.create(score_id: obj_to.score.id, price: price, name: obj_to.name)
  end

  def validate_params_for_transaction(t_params)
    user_from = t_params[:user_from]
    user_to = t_params[:user_to]
    teem_from = t_params[:teem_from]
    teem_to = t_params[:teem_to]
    price = t_params[:price]
    errors = []
    if !user_from.present? && !teem_from.present?
      errors << 'You must select user or teem from for transaction'
    elsif !user_to.present? && !teem_to.present?
      errors << 'You must select user or teem to for transaction'
    elsif !price.present?
      errors << 'You must put price for transaction'
    elsif user_from.presence && teem_from.presence
      errors << "You can't select two object from for transaction, only one, user or teem"
    elsif user_to.presence && teem_to.presence
      errors << "You can't select two object to for transaction, only one, user or teem"
    elsif (user_to == user_from) && (user_to.present? && user_from.present?)
      errors << "You can't do transaction with the same users"
    elsif (teem_from == teem_to) && (teem_to.present? && teem_from.present?)
      errors << "You can't do transaction with the same teems"
    end
    errors
 end

  def load_data
    @users = User.all
    @teems = Teem.all
    @transactions = Transaction.order(id: :desc)
  end

  private

  def t_params
    params.permit(:user_from, :teem_from, :user_to, :teem_to, :price)
  end
end
