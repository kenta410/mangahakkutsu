class DropTableTagmap < ActiveRecord::Migration[6.1]
  def change
    drop_table :tagmaps
  end
end
