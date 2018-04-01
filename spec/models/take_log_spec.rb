require 'rails_helper'

RSpec.describe TakeLog, type: :model do

  describe "抽號碼牌" do
    before do
      @takelog = TakeLog.create(card_id: 2, ip_address: "123456@xxx.com", take_count: 0)
    end
    it "今天排隊人數" do
      TakeLog.where("created_at >= ?", Time.zone.now.beginning_of_day)
    end

    it "在某個時段裡抽號碼牌" do
      expect(@takelog.card_id).to eq(2)
    end


    



    

  end
 

end