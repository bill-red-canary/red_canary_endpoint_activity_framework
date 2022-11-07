# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedCanary::ExecuteNetworkActivity do
  subject { RedCanary::ExecuteNetworkActivity.new('https://fake-domain.redcanary.com', {foo: 'bar'}) }

  describe '#call' do
    it 'creates a new network activity' do
      response = subject.call
      expect(response).to be_a(EndpointProcess)
      expect(response.name).to eq('curl')
    end
  end
end
