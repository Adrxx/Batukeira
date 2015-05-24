class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description
      t.integer :order
      #t.timestamps null: false
    end
  end
end
