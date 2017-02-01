class AddPaypalToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :paypal, :text
  end
end
