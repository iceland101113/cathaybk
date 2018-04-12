class Basic < ApplicationRecord
	validates_presence_of :age, :education, :marriage, :house, :job, :job_title, :longevity, :income

	def basic_value
		self.age.to_f + self.education.to_f + self.marriage.to_f + self.house.to_f + self.job.to_f + self.job_title.to_f + self.longevity.to_f + self.income.to_f
	end

end
