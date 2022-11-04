# frozen_string_literal: true

module RedCanary
  # ExecuteNetworkActivity accepts a URL {String} and data {JSON} param, then uses a curl command to
  # initiate a network connection.
  class ExecuteNetworkActivity
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
      data_string = data.empty? ? '' : "-d '#{data}'"
      command = "curl -X POST -H \"Content-Type: application/json\" #{data_string} -o /dev/null #{url}"
      EndpointProcess.create(command: command)
    end
  end
end
