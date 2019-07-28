class Transaction < ApplicationRecord
	validates_presence_of :score_id, :price
end
