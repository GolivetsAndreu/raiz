class TeamUser < ApplicationRecord
	validates_presence_of :user_id, :team_id
end
