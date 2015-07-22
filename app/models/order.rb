class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :products

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
end