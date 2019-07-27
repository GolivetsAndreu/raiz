class User < ApplicationRecord
	def score
		Score.find_by(object_id: id, type_object: 'user')
	end
end
