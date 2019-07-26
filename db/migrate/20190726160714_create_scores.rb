class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :object_id, null: false, default: ''
      t.integer :balans, null: false, default: ''
      t.string :type_object, null: false, default: ''
      t.timestamps
    end
  end
end
