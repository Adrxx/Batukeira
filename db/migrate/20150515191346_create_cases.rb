class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.string :description
      
      t.string :eleapsed_time
      
      t.decimal :waist_before
      t.decimal :waist_after

      t.decimal :weight_before
      t.decimal :weight_after

      t.string :product_used

      t.timestamps null: false
    end
  end
end
