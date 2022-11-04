# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedCanary::RunTests do
  subject { RedCanary::RunTests.new }

  describe '#call' do
    it 'runs the tests' do
      expect(EndpointProcess.count).to eq(0)
      expect(FileActivity.count).to eq(0)
      expect(NetworkActivity.count).to eq(0)

      response = subject.call

      expect(EndpointProcess.count).to eq(5)
      expect(FileActivity.count).to eq(3)
      expect(NetworkActivity.count).to eq(1)
      expect(response).to be_a(String)
      expect(JSON.parse(response).length).to eq(5)
    end
  end
end
