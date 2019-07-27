class User < ApplicationRecord
	has_many :teem_user

	def score
		Score.find_by(object_id: id, type_object: 'user')
	end
end
