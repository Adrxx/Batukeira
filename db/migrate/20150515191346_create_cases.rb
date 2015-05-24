class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.string :description
      t.string :eleapsed_time
      t.string :weight_loss
      t.string :product_used

      t.timestamps null: false
    end
  end
end
