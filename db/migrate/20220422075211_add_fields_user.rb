class AddFieldsUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :unconfirmed_email
      t.string :confirmation_token
      t.datetime :confirmation_sent_at
      t.datetime :confirmed_at
    end
  end
end
