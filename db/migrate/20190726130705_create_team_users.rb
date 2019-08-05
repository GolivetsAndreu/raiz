class CreateTeamUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_users do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.timestamps
    end
  end
end
