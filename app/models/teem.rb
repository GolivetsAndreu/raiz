class Teem < ApplicationRecord
	validates_presence_of :name

	has_many :teem_user

	def score
		Score.find_by(object_id: id, type_object: 'teem')
	end

	def is_teems_user?(user_id)
		teem_user.pluck(:id).include?(user_id)
	end

	def name_with_score_balans
		"#{name} #{score.balans} y.e."
	end
end
