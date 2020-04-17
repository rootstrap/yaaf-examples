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
FactoryBot.define do
  factory :coupon do
    code { "MyString" }
    user { nil }
  end
end
