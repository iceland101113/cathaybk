class AddDateToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :date, :date
  end
end
