class Basic < ApplicationRecord
	validates_presence_of :age, :education, :marriage, :house, :job, :job_title, :longevity, :income

end
