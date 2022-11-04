# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedCanary::ExecuteProcess do
  let(:command) { 'cat /proc/cpuinfo' }
  let(:service) { described_class.new(command) }

  describe '#call' do
    it 'executes the command' do
      response = service.call
      expect(response[:command]).to eq(command)
      expect(response[:name]).to eq('cat')
      expect(response[:process_id]).to be_a(Integer)
      expect(response[:start_time]).to be_a(DateTime)
      expect(response[:user_name]).to eq(ENV['USER'])
    end
  end
end
