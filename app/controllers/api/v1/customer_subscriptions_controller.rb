class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    customer_sub = CustomerSubscription.new(customer_subscription_params)
    customer_sub.save
    render json: CustomerSubscriptionSerializer.new(customer_sub), status: 201
  end

  def update
    customer_sub = CustomerSubscription.find_by(customer_subscription_params)
    subscription = Subscription.find(customer_sub.subscription_id)
    cancelled = Subscription.update(subscription.id, status: 0)
    render json: SubscriptionSerializer.new(cancelled), status: :created
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end