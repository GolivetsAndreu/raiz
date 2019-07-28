class User < ApplicationRecord
	validates_presence_of :name

	has_many :teem_user

	def score
		Score.find_by(object_id: id, type_object: 'user')
	end

	def name_with_score_balans
		"#{name} #{score.balans} y.e."
	end
end
