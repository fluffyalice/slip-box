# == Schema Information
#
# Table name: references
#
#  id      :bigint           not null, primary key
#  author  :string           not null
#  info    :text
#  title   :string           not null
#  url     :string
#  year    :integer
#  user_id :bigint
#
# Indexes
#
#  index_references_on_user_id  (user_id)
#
class Reference < ApplicationRecord
    has_many :notes
    belongs_to :user
    validates :author, :title, presence: true
end
