class Credit < ApplicationRecord
	validates_presence_of :credit_num, :credit_time, :credit_money, :credit_all_money, :credit_last, :credit_new, :credit_current_money, :credit_current_all_money, :repay_month

end
