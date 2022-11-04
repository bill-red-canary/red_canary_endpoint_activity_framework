# frozen_string_literal: true

module RedCanary
  # ExecuteFileActivity accepts a file path {String} and an action {Symbol} [:create, :update, :destroy] and
  # returns an EndpointProcess on success.
  class ExecuteFileActivity
    def initialize(file_path, action)
      return if file_path.blank? || action.blank?

      @file_path = file_path
      @action = action.to_sym
    end

    def call
      execute_file_activity(@file_path, @action)
    end

    private

    def execute_file_activity(file_path, action)
      case action
      when :create
        create_file(file_path)
      when :update
        update_file(file_path)
      when :destroy
        destroy_file(file_path)
      else
        false
      end
    end

    def create_file(file_path)
      EndpointProcess.create(command: "touch #{file_path}")
    end

    def update_file(file_path)
      return false unless File.exist?(file_path)

      EndpointProcess.create(command: "echo 'Hello World' > #{file_path}")
    end

    def destroy_file(file_path)
      EndpointProcess.create(command: "rm #{file_path}")
    end
  end
end
