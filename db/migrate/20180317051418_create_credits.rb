class CreateCredits < ActiveRecord::Migration[5.1]
  def change
    create_table :credits do |t|
      t.string :credit_num
      t.string :credit_time
      t.string :credit_money
      t.string :credit_all_money
      t.string :credit_last
      t.string :credit_new
      t.string :credit_current_money
      t.string :credit_current_all_money
      t.string :repay_month

      t.timestamps
    end
  end
end
