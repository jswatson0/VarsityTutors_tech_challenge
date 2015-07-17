class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.integer :postal_code
      t.string :country
      t.timestamps null: false
    end

    create_table :orders do |t|
      t.belongs_to :customer, index:true
      t.float :total_cost
    end

    create_table :products do |t|
      t.belongs_to :order, index:true
      t.string :name
      t.text :description
      t.float :cost
    end
  end
end
