# == Schema Information
#
# Table name: types
#
#  id          :bigint           not null, primary key
#  colour_code :string           not null
#  type_name   :string           not null
#  user_id     :bigint
#
# Indexes
#
#  index_types_on_user_id  (user_id)
#
FactoryBot.define do
  factory :type do
    
  end
end
