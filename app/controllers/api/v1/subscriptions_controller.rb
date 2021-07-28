class Api::V1::SubscriptionsController < ApplicationController

  def index
  end

  def create
    subscription = Subscription.new(subscription_params)
    subscription.save
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def delete
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end