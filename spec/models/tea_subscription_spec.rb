require 'rails_helper'
describe TeaSubscription, type: :model do
  describe 'relationships' do
    it {should belong_to(:subscription)}
    it {should belong_to(:tea)}
  end
end