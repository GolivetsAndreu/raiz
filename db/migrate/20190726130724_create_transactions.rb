class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :score_id, null: false, default: ''
      t.string :type, null: false, default: ''
      t.integer :price, null: false, default: ''
      t.timestamps
    end
  end
end
