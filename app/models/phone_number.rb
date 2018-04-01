class PhoneNumber < ApplicationRecord
  
  validates :phone_number, format: { with: /(0)(9)\d{8}/,message: "填入號碼有誤" }

  def generate_pin
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save
  end


  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_pin
    twilio_client.messages.create(
      to: "+886#{phone_number}",
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Your PIN is #{pin}"
    )
  end    

  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end    



end
