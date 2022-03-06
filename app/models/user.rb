# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  mail               :string
#  ou                 :string
#  sign_in_count      :integer          default(0)
#  sn                 :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
class User < ApplicationRecord
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include EpiCas::DeviseHelper
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :notes
  has_many :tags
  has_many :types
  has_many :references
  has_many :branch_links
  has_many :tag_links

  end
