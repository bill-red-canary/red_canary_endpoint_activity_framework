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
FactoryBot.define do
  factory :file_activity do
    file_path { 'test.txt' }
    activity { 0 }
  end
end
