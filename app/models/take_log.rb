class TakeLog < ApplicationRecord
 validates :take_count, numericality: { less_than: 7 }

  belongs_to :card, counter_cache: true
end
