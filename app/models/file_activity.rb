# frozen_string_literal: true

# == Schema Information
#
# Table name: file_activities
#
#  id                  :integer          not null, primary key
#  activity            :integer
#  file_path           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  endpoint_process_id :integer          not null
#
# Indexes
#
#  index_file_activities_on_endpoint_process_id  (endpoint_process_id)
#
# Foreign Keys
#
#  endpoint_process_id  (endpoint_process_id => endpoint_processes.id)
#
class FileActivity < ApplicationRecord
  validates_presence_of :file_path, :activity
  belongs_to :endpoint_process

  before_validation :perform_file_activity, on: :create

  enum activity: {
    create: 0,
    delete: 1,
    update: 2,
  }, _prefix: :true

  private

  def perform_file_activity
    return false if file_path.blank? || activity.blank?

    response = RedCanary::ExecuteFileActivity.new(file_path, activity).call

    self.endpoint_process = response
  end
end
