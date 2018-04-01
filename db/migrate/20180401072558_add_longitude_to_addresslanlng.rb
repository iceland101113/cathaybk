class AddLongitudeToAddresslanlng < ActiveRecord::Migration[5.1]
  def change
    add_column :addresslanlngs, :longitude, :float
  end
end
