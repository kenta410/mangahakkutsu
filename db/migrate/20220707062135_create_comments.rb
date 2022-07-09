class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.integer :comic_id, null: false
      t.integer :customer_id, null: false
      t.float :rate, null: false, default: 0
      t.text :comment, null: false

      t.timestamps
    end
  end
end
