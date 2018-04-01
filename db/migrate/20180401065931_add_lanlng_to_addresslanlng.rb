class AddLanlngToAddresslanlng < ActiveRecord::Migration[5.1]
  def change
    add_column :addresslanlngs, :latitude, :float
    add_column :addresslanlngs, :longitube, :float
  end
end
