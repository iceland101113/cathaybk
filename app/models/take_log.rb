class TakeLog < ApplicationRecord


  belongs_to :card, counter_cache: true

  def today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  
  def self.by_position
    order("position ASC")
  end

end
