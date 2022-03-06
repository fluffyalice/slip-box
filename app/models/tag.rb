# == Schema Information
#
# Table name: tags
#
#  id       :bigint           not null, primary key
#  tag_name :string           not null
#  user_id  :bigint
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#
class Tag < ApplicationRecord
    validates :tag_name, uniqueness: { scope: :user_id,
    message: "tag already exists" } , presence: true
    has_many :notes
    belongs_to :user
end
