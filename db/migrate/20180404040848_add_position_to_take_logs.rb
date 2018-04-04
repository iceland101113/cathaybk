class AddPositionToTakeLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :take_logs, :position, :integer
  end
end
