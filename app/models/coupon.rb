# == Schema Information
#
# Table name: coupons
#
#  id         :bigint           not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  used_by_id :bigint           not null
#
# Indexes
#
#  index_coupons_on_used_by_id  (used_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (used_by_id => users.id)
#
class Coupon < ApplicationRecord
  belongs_to :used_by, class_name: 'User', optional: true

  validates :code, presence: true
end
