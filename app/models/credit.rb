class Credit < ApplicationRecord
	validates_presence_of :credit_num, :credit_time, :credit_money, :credit_all_money, :credit_last, :credit_new, :credit_current_money, :credit_current_all_money, :repay_month

	def credit_value
		self.credit_num.to_f + self.credit_time.to_f + self.credit_money.to_f + self.credit_all_money.to_f + self.credit_last.to_f 
                    + self.credit_new.to_f + self.credit_current_money.to_f + self.credit_current_all_money.to_f + self.repay_month.to_f
	end	

end
