class TeemUser < ApplicationRecord
	def users
		User.find(user_id)
	end

	def teem
		Teem.find(teem_id)
	end
end
