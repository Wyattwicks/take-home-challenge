require 'rails_helper'

RSpec.describe 'Create a new customer' do
  describe 'Happy Path' do
    it 'can create a new customer' do
      customer_params = ({
        first_name: "Wyatt",
        last_name: "Wicks",
        email: "testy@example.com",
        address: "Random Address"
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/customers", headers: headers, params: JSON.generate(customer_params)

      result = JSON.parse(response.body, symbolize_names: true)
      customer = Customer.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(customer.id.to_s)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to have_key(:first_name)
      expect(result[:data][:attributes][:first_name]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:last_name)
      expect(result[:data][:attributes][:last_name]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:email)
      expect(result[:data][:attributes][:email]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:address)
      expect(result[:data][:attributes][:address]).to be_a(String)
    end
  end
end