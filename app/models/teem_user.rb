class TeemUser < ApplicationRecord
	validates_presence_of :user_id, :teem_id
end
