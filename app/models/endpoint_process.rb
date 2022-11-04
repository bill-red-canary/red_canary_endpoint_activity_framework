# frozen_string_literal: true

# == Schema Information
#
# Table name: endpoint_processes
#
#  id         :integer          not null, primary key
#  command    :text
#  name       :string
#  start_time :datetime
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  process_id :integer
#
class EndpointProcess < ApplicationRecord
  validates_presence_of :command

  after_validation :execute_process, on: :create

  private

  def execute_process
    # exit early if command is not present
    return false if command.blank?

    response = RedCanary::ExecuteProcess.new(command).call

    self.name = response[:name]
    self.process_id = response[:process_id]
    self.start_time = response[:start_time]
    self.user_name = response[:user_name]
  end
end
