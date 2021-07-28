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
      expect(response.status).to eq(201)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data].count).to eq(3)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data][:id]).to eq(subscription.id.to_s)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes].count).to eq(6)
      expect(result[:data][:attributes]).to have_key(:title)
      expect(result[:data][:attributes][:title]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:customer_id)
      expect(result[:data][:attributes][:customer_id]).to be_an(Integer)
      expect(result[:data][:attributes]).to have_key(:tea_id)
      expect(result[:data][:attributes][:tea_id]).to be_an(Integer)
      expect(result[:data][:attributes]).to have_key(:status)
      expect(result[:data][:attributes][:status]).to eq('active')
      expect(result[:data][:attributes]).to have_key(:frequency)
      expect(result[:data][:attributes][:frequency]).to be_a(Integer)
      expect(result[:data][:attributes]).to have_key(:price)
      expect(result[:data][:attributes][:price]).to be_a(Float)
    end
  end
end
