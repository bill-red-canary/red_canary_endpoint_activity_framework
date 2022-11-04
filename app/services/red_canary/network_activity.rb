# frozen_string_literal: true

module RedCanary
  # NetworkActivity accepts a URL {String} and data {JSON} param, then uses a curl command to
  # initiate a network connection.
  class NetworkActivity
    def initialize(url, data = {})
      return if url.blank?

      @url = url
      @data = data.to_json
    end

    def call
      initiate_network_connection(@url, @data)
    end

    private

    def initiate_network_connection(url, data)
      command = "curl -X POST -H \"Content-Type: application/json\" -d '#{data}' -o /dev/null #{url}"
      EndpointProcess.create(command: command)
    end
  end
end
