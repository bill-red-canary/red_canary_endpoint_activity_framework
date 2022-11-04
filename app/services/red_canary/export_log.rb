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

    def csv_headers
      EndpointProcess.attribute_names + FileActivity.attribute_names + NetworkActivity.attribute_names
    end

    private

    def export_log(format, start_date, end_date)
      log_data = EndpointProcess.started_between(start_date, end_date).includes(:file_activity, :network_activity)

      # Return early if there is no log data
      return '' if log_data.empty?

      # Return the formatted log data
      format_log_data(format, log_data)
    end

    def format_log_data(format, log_data)
      case format
      when :json
        generate_json(log_data)
      when :csv
        generate_csv(log_data)
      else
        generate_json(log_data)
      end
    end

    def generate_csv(log_data)
      CSV.generate do |csv|
        csv << csv_headers
        log_data.each do |process|
          csv << process.attributes.values +
            (process.file_activity.present? ? process.file_activity.attributes.values : []) +
            (process.network_activity.present? ? process.network_activity.attributes.values : [])
        end
      end
    end

    def generate_json(log_data)
      log_data.to_json(include: [:file_activity, :network_activity])
    end
  end
end
