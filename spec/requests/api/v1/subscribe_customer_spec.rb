require 'rails_helper'

RSpec.describe 'Subscribe a Customer' do
  describe 'Happy Path' do
    before :each do
      @customer = Customer.create!(first_name: "Test", last_name: "User",
        email: "test@example.com", address: "123 Peppermint St."
      )
      @tea = Tea.create!(title: "Test Tea", description: "Test description", temperature: 100.0, brew_time: 10.3)
    end
    it 'can create a subscription for a customer' do
      subscription_params = ({
        customer_id: @customer.id,
        tea_id: @tea.id,
        title: "Tea Subscription",
        price: 50.00,
        frequency: 2
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      result = JSON.parse(response.body, symbolize_names: true)
      subscription = Subscription.last

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
