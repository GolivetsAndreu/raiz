class Score < ApplicationRecord
	def credit(price)
		self.balans = self.balans + price
		return true if self.save
	end

	def debit(price)
		self.balans = self.balans - price
		return true if self.save
	end
end
