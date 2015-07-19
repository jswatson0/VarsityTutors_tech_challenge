class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # if customer is logged in, return current_customer, else return guest_customer
  def current_or_guest_customer
    if current_customer
      if session[:guest_user_id] && session[:guest_user_id] != current_customer.id
        logging_in
        guest_customer(with_retry = false).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_customer
    else
      guest_customer
    end
  end

  # find guest_customer object associated with the current session,
  # creating one as needed
  def guest_customer(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= Customer.find(session[:guest_user_id] ||= create_guest_customer.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_customer if with_retry
  end

  private

  # called (once) when the customer logs in, insert any code your application needs
  # to hand off from guest_customer to current_customer.
  def logging_in
    # For example:
    # guest_comments = guest_customer.comments.all
    # guest_comments.each do |comment|
    # comment.user_id = current_customer.id
    # comment.save!
    # end
  end

  def create_guest_customer
    u = Customer.create(:email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
