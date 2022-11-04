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
FactoryBot.define do
  factory :endpoint_process do
    command { "cat /proc/cpuinfo" }
  end
end
