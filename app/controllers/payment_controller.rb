class PaymentController < ApplicationController
  def index
  	@users = User.all
  	@teems = Teem.all
  end

  def transaction
  	@errors = validate_params_for_transaction(t_params)
		if @errors.any?
			render 'payment/errors', errors: @errors
		else
			errors = []
			object_from = t_params[:user_from].present? ? User.find(t_params[:user_from]) : Teem.find(t_params[:teem_from])
			object_to = t_params[:user_to].present? ? User.find(t_params[:user_to]) : Teem.find(t_params[:teem_to])
			if t_params[:type] === 'credit'
				if object_from.score.balans < t_params[:price].to_i
					errors << "Object from haven't enough money"
				elsif object_to.score.balans < t_params[:price].to_i
					errors << "Object to haven't enough money"
				end
			end
		end
	end

	private

	def validate_params_for_transaction(t_params)
		errors = []
		if !t_params[:user_from].present? && !t_params[:teem_from].present?
  		errors << "You must select user or teem from for transaction"
		elsif !t_params[:user_to].present? && !t_params[:teem_to].present?
			errors << "You must select user or teem to for transaction"
		elsif !t_params[:type].present?
			errors << "You must select transaction type"
		elsif !t_params[:price].present?
			errors << "You must put price for transaction"
		elsif (t_params[:user_from].presence) && (t_params[:teem_from].presence)
  		errors << "You can't select two object from for transaction, only one, user or teem"
		elsif (t_params[:user_to].presence) && (t_params[:teem_to].presence)
			errors << "You can't select two object to for transaction, only one, user or teem"
		elsif (t_params[:user_to] === t_params[:user_from]) && (t_params[:user_to].present? && t_params[:user_from].present?)
			errors << "You can't do transaction with the same users"
		elsif (t_params[:teem_from] === t_params[:teem_to]) && (t_params[:teem_to].present? && t_params[:teem_from].present?)
			errors << "You can't do transaction with the same teems"
		end
		errors
	end
	def t_params
		params.permit(:user_from, :teem_from, :user_to, :teem_to, :price).merge(params.require(:type_transaction).permit(:type))
	end
end
