class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :queue
      t.string :time
      t.references :user
      t.references :bank

      t.timestamps
    end
  end
end
