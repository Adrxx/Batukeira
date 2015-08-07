class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.text :values

      t.text :facebook
      t.text :twitter
      t.string :telephone
      t.string :telephone2
      t.string :email

    end
  end
end
