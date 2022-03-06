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
