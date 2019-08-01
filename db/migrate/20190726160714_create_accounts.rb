class CreateAccounts< ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :balans, null: false
      t.references :objectable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
