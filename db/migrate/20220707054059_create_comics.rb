class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|

      t.string :title
      t.text :synopsis
      t.integer :customer_id
      t.string :image_id

      t.timestamps
    end
  end
end
