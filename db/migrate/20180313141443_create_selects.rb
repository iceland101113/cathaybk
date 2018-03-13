class CreateSelects < ActiveRecord::Migration[5.1]
  def change
    create_table :selects do |t|
      t.integer :basic_id

      t.timestamps
    end
  end
end
