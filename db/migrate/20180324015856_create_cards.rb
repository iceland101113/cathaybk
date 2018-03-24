class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer  :partA, default: 0, null: false
      t.integer  :partB, default: 0, null: false
      t.integer  :partC, default: 0, null: false
      t.integer  :partD, default: 0, null: false
      t.integer  :partE, default: 0, null: false
      t.integer  :partF, default: 0, null: false
      t.timestamps
    end
  end
end
