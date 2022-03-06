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
require 'rails_helper'

describe Reference_controller do
   describe '#get_all_references' do
        it 'returns a list of all stored references' do
            expect(get_all_references).to eq ["first_reference", "second_reference", "last_reference"]
        end
   end
end
