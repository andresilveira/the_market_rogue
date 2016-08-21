class AddOperationsToAlerts < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :operation, :string
  end
end
