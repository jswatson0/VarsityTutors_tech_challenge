class Order < ActiveRecord::Base
  belongs_to :customer
  has_and_belongs_to_many :products

  def add_product(product_name, qty)
    product = Product.where(name: product_name).first
    # set the product qty
    product.qty = qty.to_i
    self.products << product
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

  def self.ounces_sold
    total_ounces = 0
    orders = Order.shipped.includes(:products)
    orders.each do |order|
      order.products.each do |product|
        if product.name == "Six Pack"
          total_ounces += (12*12) * product.qty.to_i
        else
          total_ounces += 22 * product.qty.to_i
        end
      end
    end
    total_ounces
  end

  scope :shipped, -> { where(shipped: true) }
  scope :completed, -> { where(complete: true)}
end