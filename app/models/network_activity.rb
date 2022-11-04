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
class NetworkActivity < ApplicationRecord
  belongs_to :endpoint_process

  validates_presence_of :destination_address,
                        :destination_port,
                        :data_size,
                        :data_protocol,
                        :source_address,
                        :source_port,
                        :url

  before_validation :parse_url
  before_validation :calculate_data_size
  before_validation :initiate_network_connection

  private

  def calculate_data_size
    self.data_size = data.to_json.length
  end

  def initiate_network_connection
    return false if url.blank?

    response = RedCanary::NetworkActivity.new(url, data).call

    self.endpoint_process = response
  end

  def parse_url
    parsed_url = URI.parse(url)

    self.destination_address = parsed_url.host
    self.destination_port = parsed_url.port
    self.data_protocol = parsed_url.scheme
    self.source_address = Socket.ip_address_list.detect(&:ipv4_private?).ip_address
    self.source_port = 0
  rescue URI::InvalidURIError
    return ArgumentError, "Invalid URL: #{url}"
  end
end
