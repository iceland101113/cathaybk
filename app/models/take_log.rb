class TakeLog < ApplicationRecord

  enum status: { 未提醒: 0, 已提醒: 1}
  belongs_to :card, counter_cache: true


  

  private

  


  def self.today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  
  def self.by_position
    order("position ASC")
  end



   

end
