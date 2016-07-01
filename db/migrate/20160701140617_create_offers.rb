class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :item_name
      t.string :cards
      t.integer :price
      t.integer :amount
      t.string :vendor
      t.string :shop_title
      t.string :map_location

      t.timestamps null: false
    end

    create_index :offers, [
      :item_name,
      :cards,
      :price,
      :amount,
      :vendor,
      :shop_title,
      :map_location
    ], unique: true
  end
end
