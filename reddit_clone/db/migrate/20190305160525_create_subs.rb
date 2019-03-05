class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false

      t.timestamps
      t.index :title, unique: true
      t.index :moderator_id
    end
  end
end
