class PaymentController < ApplicationController
  def index
  	@users = User.all
  	@teems = Teem.all
  end

  def transaction
  	@users = User.all
		@teems = Teem.all
  	@errors = validate_params_for_transaction(t_params)
		if @errors.any?
			render 'payment/errors', errors: @errors
		else
			@errors = []
			error = false
			obj_from = t_params[:user_from].present? ? User.find(t_params[:user_from]) : Teem.find(t_params[:teem_from])
			obj_to = t_params[:user_to].present? ? User.find(t_params[:user_to]) : Teem.find(t_params[:teem_to])
			type_obj_from = t_params[:user_from].present? ? 'user' : 'teem'
			price = t_params[:price].to_i
			@transaction_status
			if obj_from.score.balans < price
				error = true
				@errors << "Object from haven't enough money for transaction"
			end

			if type_obj_from === 'user' && !error
				transaction_status = obj_from.score.debit(price) && obj_to.score.credit(price) ? 'success' : 'fail'
			elsif !error
				if obj_from.is_teems_user?(obj_to.id)
					transaction_status = obj_from.score.debit(price) && obj_to.score.credit(price) ? 'success' : 'fail'
				else
					error = true
					@errors << "User isn't a teem's member"
				end
			end
			@transaction_result = transaction_status === 'success' ? 'Transaction have done success' : 'Something went wrong'
			render 'payment/errors', errors: @errors if error 
			render 'payment/index', transaction_status: @transaction_result unless error
		end
	end

	private

	def validate_params_for_transaction(t_params)
		errors = []
		if !t_params[:user_from].present? && !t_params[:teem_from].present?
  		errors << "You must select user or teem from for transaction"
		elsif !t_params[:user_to].present? && !t_params[:teem_to].present?
			errors << "You must select user or teem to for transaction"
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
		params.permit(:user_from, :teem_from, :user_to, :teem_to, :price)
	end
end
