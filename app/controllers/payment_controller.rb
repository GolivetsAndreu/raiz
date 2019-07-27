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
			type_obj_to = !t_params[:user_to].present? ? 'teem' : 'user'
			price = t_params[:price].to_i
			@transaction_status
			unless obj_from.score.enough_money?(price) 
				error = true
				@errors << "Object from haven't enough money for transaction"
			end

			if type_obj_from === 'user' && !error
				transaction_status = transaction_with_users(obj_from, obj_to, price)
			elsif !error
				args = { type_obj_from: type_obj_from, type_obj_to: type_obj_to, obj_from: obj_from, obj_to: obj_to, price: price }
				result = transaction_from_teem(args)
				if result[:errors].present?
					error = true
					@errors << result[:errors]
				else
					transaction_status = result[:transaction_status]
				end
			end

			if transaction_status === 'success' 
				@transaction_result = 'Transaction have done success'
				create_transaction_history(obj_from, obj_to, price)
			else
			  @transaction_result = 'Something went wrong'
		 	end
			render 'payment/errors', errors: @errors if error 
			render 'payment/index', transaction_status: @transaction_result unless error
		end
	end

	def transaction_with_users(user_from, user_to, price)
		user_from.score.debit(price) && user_to.score.credit(price) ? 'success' : 'fail'
	end

	def transaction_from_teem(args)
		result = { errors: '', transaction_status: ''}

		if args[:type_obj_from] == args[:type_obj_to]
			result[:errors] = "Teem can't do transaction with another teem"
			return result
		end

		unless args[:obj_from].is_teems_user?(args[:obj_to].id)
			result[:errors] = "User isn't a teem's member"
			return result
		end

		transaction_status = args[:obj_from].score.debit(args[:price]) && args[:obj_to].score.credit(args[:price]) ? 'success' : 'fail'
		result[:transaction_status] = transaction_status
		result
	end

	def create_transaction_history(obj_from, obj_to, price)
		debit_transaction = DebitTransaction.new({ score_id: obj_from.score.id, price: price })
		credit_transaction = CreditTransaction.new({ score_id: obj_to.score.id, price: price })
		debit_transaction.save && credit_transaction.save
	end

	def validate_params_for_transaction(t_params)
		user_from = t_params[:user_from]
		user_to = t_params[:user_to]
		teem_from = t_params[:teem_from]
		teem_to = t_params[:teem_to]
		price = t_params[:price]
		errors = []
		if !user_from.present? && !teem_from.present?
  		errors << "You must select user or teem from for transaction"
		elsif !user_to.present? && !teem_to.present?
			errors << "You must select user or teem to for transaction"
		elsif !price.present?
			errors << "You must put price for transaction"
		elsif (user_from.presence) && (teem_from.presence)
  		errors << "You can't select two object from for transaction, only one, user or teem"
		elsif (user_to.presence) && (teem_to.presence)
			errors << "You can't select two object to for transaction, only one, user or teem"
		elsif (user_to === user_from) && (user_to.present? && user_from.present?)
			errors << "You can't do transaction with the same users"
		elsif (teem_from === teem_to) && (teem_to.present? && teem_from.present?)
			errors << "You can't do transaction with the same teems"
		end
		errors
	end

	private

	def t_params
		params.permit(:user_from, :teem_from, :user_to, :teem_to, :price)
	end
end
