class PaymentController < ApplicationController
  def index
  	params_for_form
  end

  def transaction
  	@errors = []
  	if transaction_params[:user_from] && transaction_params[:teem_from]
  		@errors << "You can't select two object from for transaction, only one, user or teem"
		elsif transaction_params[:user_to] && transaction_params[:teem_to]
			@errors << "You can't select two object to for transaction, only one, user or teem"
		elsif transaction_params[:type_transaction]
			@errors << "You must select transaction type"
		end
		if @errors.any?
			render template: '/payment/errors', errors: @errors
		end
	end

	def params_for_form
		@users = User.all
  	@teems = Teem.all
	end

	private

	def transaction_params
		params.permit(:user_from, :teem_from, :user_to, :teem_to, :type_transaction)
	end
end
