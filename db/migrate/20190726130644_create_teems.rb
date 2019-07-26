class CreateTeems < ActiveRecord::Migration[5.1]
  def change
    create_table :teems do |t|
      t.string :name, null: false, default: ''
      t.timestamps
    end
  end
end
