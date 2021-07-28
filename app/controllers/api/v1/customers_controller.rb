class Api::V1::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    customer.save
    render json: CustomersSerializer.new(customer), status: :created
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end