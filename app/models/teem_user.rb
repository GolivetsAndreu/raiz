class TeemUser < ApplicationRecord
	validates_presence_of :user_id, :teem_id

	def users
		User.find(user_id)
	end

	def teem
		Teem.find(teem_id)
	end
end
