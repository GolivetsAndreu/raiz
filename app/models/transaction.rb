class Transaction < ApplicationRecord
  TYPES_TRANSACTION = %w[Credit Debit]
	validates_presence_of :score_id, :price
end
