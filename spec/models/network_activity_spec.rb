# frozen_string_literal: true

# == Schema Information
#
# Table name: network_activities
#
#  id                  :integer          not null, primary key
#  data                :text
#  data_protocol       :string
#  data_size           :integer
#  destination_address :string
#  destination_port    :integer
#  source_address      :string
#  source_port         :integer
#  url                 :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  endpoint_process_id :integer          not null
#
# Indexes
#
#  index_network_activities_on_endpoint_process_id  (endpoint_process_id)
#
# Foreign Keys
#
#  endpoint_process_id  (endpoint_process_id => endpoint_processes.id)
#
require 'rails_helper'

RSpec.describe NetworkActivity, type: :model do
  describe '#call' do
    let!(:network_activity) { create(:network_activity) }

    describe 'validations' do
      it { should validate_presence_of(:url) }
    end

    describe 'associations' do
      it { should belong_to(:endpoint_process) }
    end

    describe 'private methods' do
      describe '#perform_network_activity' do
        it 'creates a new endpoint process' do
          expect(network_activity.persisted?).to be(true)
          expect(network_activity.url).to eq('https://fake-domain.redcanary.com')
          expect(network_activity.data.to_s).to eq({ foo: 'bar' }.to_s)
          expect(network_activity.endpoint_process.persisted?).to be(true)
          expect(network_activity.endpoint_process.name).to eq("curl")
        end

        it 'returns false if url is blank' do
          network_activity = described_class.create(url: '')
          expect(network_activity.persisted?).to be(false)
        end
      end
    end
  end
end
