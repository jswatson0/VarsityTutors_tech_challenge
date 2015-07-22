class CustomersController < ApplicationController
  def update
    @customer = Customer.find(params[:id])

    if @customer.update_attributes(customer_params)
      redirect_to(root_path, notice: "Your order has been placed successfully")
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name,
                                     :last_name,
                                     :email,
                                     :street,
                                     :city,
                                     :state,
                                     :postal_code,
                                     :country
                                    )
  end
end