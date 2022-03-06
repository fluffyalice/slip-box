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
class Type < ApplicationRecord
    validates :type_name, uniqueness: { scope: :user_id,
    message: "type already exists" }, presence: true
    has_many :notes
    belongs_to :user
end
