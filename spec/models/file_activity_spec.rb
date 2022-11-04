# frozen_string_literal: true

# == Schema Information
#
# Table name: file_activities
#
#  id                  :integer          not null, primary key
#  activity            :integer
#  file_path           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  endpoint_process_id :integer          not null
#
# Indexes
#
#  index_file_activities_on_endpoint_process_id  (endpoint_process_id)
#
# Foreign Keys
#
#  endpoint_process_id  (endpoint_process_id => endpoint_processes.id)
#
require 'rails_helper'

RSpec.describe FileActivity, type: :model do
  let!(:file_activity) { create(:file_activity) }

  describe 'validations' do
    it { should validate_presence_of(:file_path) }
    it { should validate_presence_of(:activity) }
  end

  describe 'associations' do
    it { should belong_to(:endpoint_process) }
  end

  describe 'private methods' do
    describe '#perform_file_activity' do
      it 'creates a new endpoint process' do
        expect(file_activity.endpoint_process.persisted?).to be(true)
        expect(file_activity.endpoint_process.command).to eq("touch #{file_activity.file_path}")
        expect(file_activity.file_path).to eq(file_activity.file_path)
        expect(file_activity.activity).to eq('create')
      end

      it 'returns false if file_path is blank' do
        file_activity = described_class.create(file_path: '', activity: :create)
        expect(file_activity.persisted?).to be(false)
      end

      it 'returns false if activity is blank' do
        file_activity = described_class.create(file_path: 'test.txt', activity: '')
        expect(file_activity.persisted?).to be(false)
      end
    end
  end
end
