class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table 'transactions', force: :cascade do |t|
      t.integer 'from_score_id', null: false
      t.integer 'to_score_id', null: false
      t.integer 'amount', null: false
      t.timestamps
    end
  end
end
