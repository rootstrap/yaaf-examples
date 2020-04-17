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
class AccountTransaction < ApplicationRecord
  belongs_to :paid_by, class_name: 'AccountTransaction', optional: true
  belongs_to :product, optional: true
  belongs_to :user

  def amount
    amount_cents / 100.0
  end
end
