class AddTrackBuyersToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :track_buyers, :boolean
  end
end
