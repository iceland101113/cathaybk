class AddStatusToTakeLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :take_logs, :status, :integer, default: 0
  end
end
