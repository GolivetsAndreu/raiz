class Score < ApplicationRecord
	validates_presence_of :object_id, :balans, :type_object

	def credit(price)
		self.balans = self.balans + price
		return true if self.save
	end

	def debit(price)
		self.balans = self.balans - price
		return true if self.save
	end

	def enough_money?(price)
		self.balans > price
	end
end
