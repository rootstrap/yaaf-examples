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
require 'rails_helper'

RSpec.describe Coupon, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
