# == Schema Information
#
# Table name: notes
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  last_edit    :datetime         not null
#  position     :integer          not null
#  title        :string           not null
#  reference_id :bigint
#  thread_id    :integer          not null
#  type_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_notes_on_reference_id  (reference_id)
#  index_notes_on_type_id       (type_id)
#  index_notes_on_user_id       (user_id)
#
FactoryBot.define do
  factory :note do
    
  end
end
