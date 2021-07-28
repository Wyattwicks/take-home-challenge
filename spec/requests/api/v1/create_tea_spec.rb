require 'rails_helper'

RSpec.describe 'Create Tea' do
  describe 'Happy Path' do
    it 'can create a new tea' do
      tea_params = ({
        title: "New Tea",
        description: "It's tea time",
        temperature: 200.0,
        brew_time: 30.2
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/teas", headers: headers, params: JSON.generate(tea_params)

      result = JSON.parse(response.body, symbolize_names: true)
      tea = Tea.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data][:id]).to eq(tea.id.to_s)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes].count).to eq(4)
      expect(result[:data][:attributes]).to have_key(:title)
      expect(result[:data][:attributes][:title]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:description)
      expect(result[:data][:attributes][:description]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:temperature)
      expect(result[:data][:attributes][:temperature]).to be_a(Float)
      expect(result[:data][:attributes]).to have_key(:brew_time)
      expect(result[:data][:attributes][:brew_time]).to be_a(Float)
    end
  end
end