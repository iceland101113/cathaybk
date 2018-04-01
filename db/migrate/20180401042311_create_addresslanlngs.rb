class CreateAddresslanlngs < ActiveRecord::Migration[5.1]
  def change
    create_table :addresslanlngs do |t|
      t.string :address

      t.timestamps
    end
  end
end
