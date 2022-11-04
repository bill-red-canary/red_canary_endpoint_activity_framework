# frozen_string_literal: true

module RedCanary
  # ExecuteProcess accepts a single {String} argument and returns {Hash} of Process data.
  class ExecuteProcess
    def initialize(command)
      @command = command
    end

    def call
      execute_command(@command)
    end

    private

    def execute_command(command)
      # Executes the command on the host system
      pid = Process.spawn(command) rescue nil

      # Return early if the process could not be spawned
      return {} unless pid

      process_name = command.split(' ').first
      process_detail_command = "ps -p #{pid} -wo lstart"
      process_start_time = DateTime.parse(`#{process_detail_command}`.split("\n").last)

      {
        command: command,
        name: process_name,
        process_id: pid,
        start_time: process_start_time,
        user_name: ENV['USER']
      }
    end
  end
end
