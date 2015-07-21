class OrdersController < ApplicationController
  def new
    @products = Product.all
    @order = Order.new
  end

  def create
    @order = Order.new(customer: current_or_guest_customer)
    @order.add_product(Product.first)

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