class CreateAddressLanlngs < ActiveRecord::Migration[5.1]
  def change
    create_table :address_lanlngs do |t|
      t.string :address

      t.timestamps
    end
  end
end
