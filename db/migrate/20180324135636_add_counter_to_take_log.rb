class AddCounterToTakeLog < ActiveRecord::Migration[5.1]
  def change
    add_column :take_logs, :take_count, :integer, default: 0
  end
end
