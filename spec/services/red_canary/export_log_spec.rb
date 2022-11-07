# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedCanary::ExportLog do
  let(:service) { RedCanary::ExportLog.new }

  describe '#call' do
    context 'when there is no log data' do
      it 'returns an empty string' do
        expect(service.call).to eq('')
      end
    end

    context 'when there is log data' do
      let!(:endpoint_process) { create(:endpoint_process) }
      let!(:file_activity) { create(:file_activity) }
      let!(:network_activity) { create(:network_activity) }

      it 'returns a JSON string of the log data' do
        expect(service.call).to eq(EndpointProcess.all.to_json(include: [:file_activity, :network_activity]))
      end

      it 'returns a CSV string of the log data' do
        response = RedCanary::ExportLog.new(format: :csv).call
        parsed_csv = CSV.parse(response)

        expect(parsed_csv[0]).to eq(RedCanary::ExportLog.new.csv_headers)
        expect(parsed_csv[1]).to eq(EndpointProcess.first.attributes.values.map{|val| val.to_s})
        file_process = EndpointProcess.second
        expect(parsed_csv[2]).to eq(file_process.attributes.values.map{|val| val.to_s} +
                                      file_process.file_activity.attributes.values.map{|val| val.to_s})
        network_process = EndpointProcess.third
        expect(parsed_csv[3]).to eq(network_process.attributes.values.map{|val| val.to_s} +
                                      network_process.network_activity.attributes.values.map{|val| val.to_s})
      end
    end
  end
end
