class SetDefaultTotalCost < ActiveRecord::Migration
  def change
    change_column :orders, :total_cost, :float, default: 0
  end
end
