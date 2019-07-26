class CreateTeemUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :teem_users do |t|
      t.integer :user_id, null: false, default: ''
      t.integer :teem_id, null: false, default: ''
      t.timestamps
    end
  end
end
