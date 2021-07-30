
require 'rails_helper'
describe "Show all of a customer's subscriptions" do
  before :each do
    customer1_params = ({
        first_name: "Wyatt",
        last_name: "Wicks",
        email: "testy@example.com",
        address: "Random Address"
        })
    @customer1 = Customer.create(customer1_params)

    customer2_params = ({
        first_name: "YYYY",
        last_name: "ZZZZZ",
        email: "abc@example.com",
        address: "Random Address 2"
        })
    @customer2 = Customer.create(customer2_params)

    subscription_params1 = ({
      title: "New samples",
      price: 30.5,
      status: 1,
      frequency: 2,
      })
    @subscription1 = Subscription.create(subscription_params1)

    subscription_params2 = ({
      title: "good teas",
      price: 50.5,
      status: 0,
      frequency: 3,
      })
    @subscription2 = Subscription.create(subscription_params2)

    subscription_params3 = ({
      title: "other teas",
      price: 30.5,
      status: 1,
      frequency: 6,
      })
    @subscription3 = Subscription.create(subscription_params3)

    @customer_sub_params1 = ({
      customer_id: @customer1.id,
      subscription_id: @subscription1.id
        })
    @subscription_customer1 = CustomerSubscription.create(@customer_sub_params1)

    @customer_sub_params2 = ({
      customer_id: @customer1.id,
      subscription_id: @subscription2.id
        })
    @subscription_customer2 = CustomerSubscription.create(@customer_sub_params2)

    @customer_sub_params3 = ({
      customer_id: @customer1.id,
      subscription_id: @subscription3.id
        })
    @subscription_customer3 = CustomerSubscription.create(@customer_sub_params3)

    @customer_sub_params4 = ({
      customer_id: @customer2.id,
      subscription_id: @subscription1.id
        })
    @subscription_customer1 = CustomerSubscription.create(@customer_sub_params4)
  end
  describe 'Happy path' do 
    it 'can show all of a customers subscriptions active or cancelled' do
      
      headers = {"CONTENT_TYPE" => "application/json"}
      get "/api/v1/customer_subscriptions/#{@customer1.id}", headers: headers, params: JSON.generate(@customer1)

      customer_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(customer_subscriptions[:data].length).to eq(3)
    end
  end
end