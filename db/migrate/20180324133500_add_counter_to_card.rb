class AddCounterToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :take_logs_count, :integer
  end
end
