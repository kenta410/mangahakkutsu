class RemoveImagrIdFromComics < ActiveRecord::Migration[6.1]
  def change
    remove_column :comics, :image_id, :string
  end
end
