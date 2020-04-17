# == Schema Information
#
# Table name: account_transactions
#
#  id           :bigint           not null, primary key
#  amount_cents :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  paid_by_id   :bigint
#  product_id   :bigint
#  user_id      :bigint           not null
#
# Indexes
#
#  index_account_transactions_on_paid_by_id  (paid_by_id)
#  index_account_transactions_on_product_id  (product_id)
#  index_account_transactions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (paid_by_id => account_transactions.id)
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
