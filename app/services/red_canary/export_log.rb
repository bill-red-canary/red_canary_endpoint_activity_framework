# frozen_string_literal: true

module RedCanary
  # ExportLog accepts 3 optional parameters: format {Symbol} [:csv, :json], start_date {DateTime}, end_date {DateTime}
  # It then returns a {String} of the log data.

  class ExportLog
    require 'csv'

    def initialize(format: :json, start_date: DateTime.now - 1.year, end_date: DateTime.now)
      @format = format
      @start_date = start_date
      @end_date = end_date
    end

    def call
      export_log(@format, @start_date, @end_date)
    end

    private

    def export_log(format, start_date, end_date)
      log_data = EndpointProcess.started_between(start_date, end_date)

      # Return early if there is no log data
      return '' if log_data.empty?

      # Return the formatted log data
      format_log_data(format, log_data)
    end

    def format_log_data(format, log_data)
      case format
      when :json
        log_data.to_json
      when :csv
        CSV.generate do |csv|
          csv << log_data.first.attributes.keys
          log_data.each do |process|
            csv << process.attributes.values
          end
        end
      else
        log_data.to_json
      end
    end
  end
end
