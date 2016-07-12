class AddTypeToOffer < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :type, :string
    add_index :offers, :type
  end
end
