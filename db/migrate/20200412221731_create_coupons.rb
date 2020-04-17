class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.belongs_to :used_by, null: false, foreign_key: { to_table: :users }
      t.string :code

      t.timestamps
    end
  end
end
