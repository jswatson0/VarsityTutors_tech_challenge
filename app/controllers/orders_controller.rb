class OrdersController < ApplicationController
  def new
    @products = Product.all
    @order = Order.new
  end

  def create
    products = Product.all
    @order = Order.new(customer: current_or_guest_customer)


    # collect the selected products
    order_products = []
    products.each do |product|
      if params[product.name]
        order_products << {"name" =>product.name, "qty" => params["#{product.name}_qty"]}
      end
    end

    # add selected products to the order
    order_products.each do |product|
      @order.add_product(product["name"], product["qty"])
    end

    respond_to do |f|
      if @order.save
        f.html { redirect_to order_shipping_info_path(@order.id) }
      else
        f.html { render :new }
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def shipping_info
    @order = Order.find(params[:id])
    @customer = @order.customer
  end
end