class CreateTakes < ActiveRecord::Migration[5.1]
  def change
    create_table :take_logs do |t|
      t.references :card, foreign_key: true, default: 0
      t.string :ip_address

      t.timestamps
    end
  end
end
