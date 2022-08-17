class DropTableComicTag < ActiveRecord::Migration[6.1]
  def change
    drop_table :comic_tags
  end
end
