require 'rails_helper'

RSpec.describe 'Delete a customer subscription' do
  before :each do
    customer_params = ({
        first_name: "Wyatt",
        last_name: "Wicks",
        email: "testy@example.com",
        address: "Random Address"
        })
    @customer = Customer.create(customer_params)

    tea_params = ({
      title: "New Tea",
      description: "It's tea time",
      temperature: 200.0,
      brew_time: 30.2
      })

    @tea = Tea.create(tea_params)

    subscription_params = ({
      title: "New samples",
      price: 30.5,
      status: 1,
      frequency: 2,
      })

    @subscription = Subscription.create(subscription_params)

    @customer_sub_params = ({
      customer_id: @customer.id,
      subscription_id: @subscription.id
        })

    @subscription_customer = CustomerSubscription.create(@customer_sub_params)

  end
  describe 'Happy Path' do
    it "can cancel a customer subscription" do 

      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/customer_subscriptions/#{@subscription_customer.id}", headers: headers, params: JSON.generate(@customer_sub_params)
      cancelled_subscription = Subscription.find(@subscription.id)
      expect(cancelled_subscription.status).to eq("cancelled")
    end
  end
end