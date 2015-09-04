class CreateContactModels < ActiveRecord::Migration
  def change
    create_table :contact_models do |t|

      t.timestamps null: false
    end
  end
end
