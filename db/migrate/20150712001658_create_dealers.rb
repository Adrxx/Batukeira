class CreateDealers < ActiveRecord::Migration
  def change
    create_table :dealers do |t|
      t.string :name

      t.string :telephone
      t.boolean :hidden_telephone

      t.string :telephone2
      t.boolean :hidden_telephone2

      t.string :email
      t.boolean :hidden_email

      t.text :address
      t.boolean :hidden_address

      t.text :visible_address

      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
