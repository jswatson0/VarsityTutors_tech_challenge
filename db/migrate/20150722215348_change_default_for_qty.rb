class ChangeDefaultForQty < ActiveRecord::Migration
  def change
    change_column_default :products, :qty, 1
  end
end
