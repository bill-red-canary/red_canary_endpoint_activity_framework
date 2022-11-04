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
    command { "MyText" }
    name { "MyString" }
    process_id { "MyString" }
    start_time { "2022-11-04 09:54:35" }
    user_name { "MyString" }
  end
end
