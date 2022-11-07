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
FactoryBot.define do
  factory :network_activity do
    url { 'https://fake-domain.redcanary.com' }
    data { { foo: 'bar' } }
  end
end
