class AddIsDeleteToComics < ActiveRecord::Migration[6.1]
  def change
    add_column :comics, :is_delete, :boolean, default: false
  end
end
