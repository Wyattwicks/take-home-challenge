class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    customer_sub = CustomerSubscription.new(customer_subscription_params)
    customer_sub.save
    render json: CustomerSubscriptionSerializer.new(customer_sub), status: 201
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end