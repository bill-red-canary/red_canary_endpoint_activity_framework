# frozen_string_literal: true

# == Schema Information
#
# Table name: endpoint_processes
#
#  id         :integer          not null, primary key
#  command    :text
#  name       :string
#  start_time :datetime
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  process_id :integer
#
require 'rails_helper'

RSpec.describe EndpointProcess, type: :model do
  it { should validate_presence_of(:command) }

  describe 'associations' do
    it { should have_one(:file_activity).dependent(:destroy) }
  end

  describe 'on create' do
    let(:command) { 'cat /proc/cpuinfo' }
    let(:process) { described_class.create(command: command) }

    it 'executes the command' do
      process.reload
      expect(process.name).to eq('cat')
      expect(process.process_id).to be_a(Integer)
      expect(process.start_time.present?).to be(true)
      expect(process.user_name).to eq(ENV['USER'])
    end

    it 'creates an empty record if the command is not valid' do
      process = described_class.create(command: 'invalid command')
      expect(process.command).to eq('invalid command')
      expect(process.persisted?).to be(true)
      expect(process.name).to be_nil
      expect(process.process_id).to be_nil
      expect(process.start_time).to be_nil
      expect(process.user_name).to be_nil
    end
  end
end
