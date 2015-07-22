class AddDefaultToCost < ActiveRecord::Migration
  def change
    change_column :products, :cost, :decimal, :default => 0
  end
end
