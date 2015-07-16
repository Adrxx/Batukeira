class CreateDealers < ActiveRecord::Migration
  def change
    create_table :dealers do |t|
      t.string :name
      t.string :telephone
      t.string :telephone2
      t.text :address
      t.float :latitide
      t.float :longitude

      t.timestamps null: false
    end
  end
end
