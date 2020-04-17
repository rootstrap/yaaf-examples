# == Schema Information
#
# Table name: invites
#
#  id                 :bigint           not null, primary key
#  invited_user_email :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Invite < ApplicationRecord
end
