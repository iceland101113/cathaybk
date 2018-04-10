class Card < ApplicationRecord
  
  has_many :take_logs

  def over?
  	return true if self.points > 6
  end

  def points
    self.take_logs.today.size 
  end

  
end
