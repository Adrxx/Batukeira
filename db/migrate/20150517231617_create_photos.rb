class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description
      
      t.integer :year
      t.integer :month
      t.decimal :weight

      t.integer :order
      #t.timestamps null: false
    end
  end
end
