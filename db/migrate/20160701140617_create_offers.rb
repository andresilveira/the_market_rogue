class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.string :item_name
      t.integer :slots
      t.integer :refinement
      t.string :cards
      t.integer :price
      t.integer :amount
      t.string :vendor
      t.string :shop_title
      t.string :map_location

      t.timestamps null: false
    end
  end
end
