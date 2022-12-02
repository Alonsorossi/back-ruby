class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.integer :number
      t.date :expdate
      t.boolean :tipe
      t.string :niftransmitter
      t.string :nifreceiver
      t.string :concept
      t.float :totalcount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
