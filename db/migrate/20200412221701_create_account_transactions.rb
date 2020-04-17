class CreateAccountTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :account_transactions do |t|
      t.belongs_to :paid_by, foreign_key: { to_table: :account_transactions }
      t.belongs_to :product, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :amount_cents

      t.timestamps
    end
  end
end
