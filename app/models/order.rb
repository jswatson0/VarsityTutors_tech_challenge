class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :products

  def add_product(product_name)
    product = Product.where(name: product_name).first
    self.products << product
    self.update_total_cost(product.cost)
  end

  def update_total_cost(product_cost)
    self.total_cost += product_cost
  end
end