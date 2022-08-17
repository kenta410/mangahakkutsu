class AddComicIdToTag < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :comic_id, :integer
  end
end
