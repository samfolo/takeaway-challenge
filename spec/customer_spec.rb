require 'customer'

RSpec.describe Customer do
  let(:sam) { Customer.new(:sam, ENV['MY_PHONE_NUMBER'], 100) }
  let(:jeff) { Customer.new(:jeff) }

  it 'has a default balance of £0' do
    expect(jeff.balance).to be 0
  end

  it 'should have a phone number' do
    expect(sam.number).to eq ENV['MY_PHONE_NUMBER']
  end

  describe 'test_customer_1' do
    it 'has a balance of £100' do
      expect(sam.balance).to be 100
    end
  end

  describe '#charge' do
    it 'reduces the balance of the account by the charged amount' do
      sam.charge(12)

      expect(sam.balance).to be 88
    end
  end
end
