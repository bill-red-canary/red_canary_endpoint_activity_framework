# frozen_string_literal: true

module RedCanary
  # RunTests is a service class that executes a series of tests on an endpoint, then returns a log export.

  class RunTests

    def initialize
      @start_time = DateTime.now
    end

    def call
      # Execute a process
      execute_process('cat /proc/cpuinfo')

      # Create a file
      file_path = "/tmp/#{SecureRandom.hex(8)}.txt"
      execute_file_activity(file_path, :create)

      # Update the file
      execute_file_activity(file_path, :update)

      # Destroy the file
      execute_file_activity(file_path, :delete)

      # Make a network request
      execute_network_activity('https://www.redcanary.com', {foo: 'bar'})

      # Return the log data
      export_log(:json, @start_time, DateTime.now)
    end

    private

    def execute_process(command)
      EndpointProcess.create(command: command)
    end

    def execute_file_activity(file_path, action)
      FileActivity.create(file_path: file_path, activity: action)
    end

    def execute_network_activity(url, data)
      NetworkActivity.create(url: url, data: data)
    end

    def export_log(format, start_time, end_time)
      # Process clock times may differ from rails clock times.
      # This is a workaround to ensure the correct data is returned.
      # (Only pull records created in tis time-frame)
      processes_created_since_start_time = EndpointProcess.where(created_at: start_time..end_time)
      process_start_time = processes_created_since_start_time.first.start_time
      process_end_time = processes_created_since_start_time.last.start_time

      ExportLog.new(format: format, start_time: process_start_time, end_time: process_end_time).call
    end
  end
end
