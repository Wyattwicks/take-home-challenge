require 'rails_helper'

RSpec.describe 'Create a new customer subscription' do
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

  end
  describe 'Happy Path' do
    it "can create a customer subscription" do 

      customer_sub_params = ({
      customer_id: @customer.id,
      subscription_id: @subscription.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(customer_sub_params)

      result = JSON.parse(response.body, symbolize_names: true)
      subscription_customer = CustomerSubscription.last
      
      expect(subscription_customer.customer).to eq(@customer)
      expect(subscription_customer.subscription).to eq(@subscription)

    end

  end
end