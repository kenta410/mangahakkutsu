class RemoveIsDeleteFromCoustomer < ActiveRecord::Migration[6.1]
  def change
    remove_column :coustomers, :is_derete, :boolean, default: false
  end
end
