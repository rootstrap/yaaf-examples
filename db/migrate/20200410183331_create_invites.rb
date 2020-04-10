class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.string :invited_user_email

      t.timestamps
    end
  end
end
