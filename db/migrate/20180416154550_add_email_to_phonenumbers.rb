class AddEmailToPhonenumbers < ActiveRecord::Migration[5.1]
  def change
    add_column :phone_numbers, :email, :string, null: false, default: ""
  end
end
