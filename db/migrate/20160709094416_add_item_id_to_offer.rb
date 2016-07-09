class AddItemIdToOffer < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :item_id, :integer
    add_index :offers, :item_id
  end
end
