class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.references :item, foreign_key: true
      t.integer :price
      t.string :offer_type
      t.string :type

      t.timestamps
    end

    add_index :alerts, :type
  end
end
