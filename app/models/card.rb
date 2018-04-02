class Card < ApplicationRecord
  
  has_many :take_logs

  def points
    self.take_logs.today.size 
  end
  
end
