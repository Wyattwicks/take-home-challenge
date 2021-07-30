class Api::V1::SubscriptionsController < ApplicationController


  def create
    subscription = Subscription.new(subscription_params)
    subscription.save
  end


  private

  def subscription_params
    params.permit(:title, :price, :frequency, :status)
  end
end