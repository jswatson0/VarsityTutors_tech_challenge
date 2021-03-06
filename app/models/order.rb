class Order < ActiveRecord::Base
  belongs_to :customer
  has_and_belongs_to_many :products

  def add_product(product_name, qty)
    product = Product.where(name: product_name).first
    # set the product qty
    product.qty = qty.to_i
    product.order_id = self.id
    self.products << product
    self.products.last.save!
    self.update_total_cost(product.cost, qty)
  end

  def update_total_cost(product_cost, qty)
    product_cost *= qty.to_i
    self.total_cost += product_cost
  end

  def confirm
    self.shipped = true
    self.complete = true
    self.save!
  end

  def self.units_sold
    total_units = 0
    orders = Order.shipped.includes(:products)
    orders.each do |order|
      order.products.each do |product|
        if product.name == "Six Pack"
          total_units += 12 * product.qty.to_i
        elsif product.name == "Bomber"
          total_units += product.qty.to_i
        end
      end
    end
    total_units
  end

  scope :shipped, -> { where(shipped: true) }
  scope :completed, -> { where(complete: true)}
end