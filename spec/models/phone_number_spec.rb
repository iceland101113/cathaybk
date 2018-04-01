require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  describe "#generate_pin" do
    context "驗證號碼" do
      before do
        @phone_number = PhoneNumber.create(phone_number: "0932130072" , pin: "1234", verified: "true")
      end
      it 'phone_number can be create ' do
        expect(@phone_number).to be_valid
      end
      it "驗證碼是四位數" do
        @phone_number.pin = rand(0000..9999).to_s.rjust(4, "0").size
     
        expect( @phone_number.pin).to eq("4")
       end
       
    end
  end
  describe "twilio API" do 
    before do
      @twilio_api = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    end
     it '可傳送訊息' do
      @twilio_api.messages.create(
        to: "+886#{932130072}",
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: "Your PIN is #{1234}"
        )
       
     end
  end
  describe "#verify" do
    before do
      @phone_number = PhoneNumber.create(phone_number: "0932130072" , pin: "1234", verified: "true")
    end
    it '可以驗證號碼' do
      entered_pin = "1234"
      expect( @phone_number.pin).to eq(entered_pin)
    end
  end
  
end