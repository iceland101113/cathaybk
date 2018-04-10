class PhoneNumber < ApplicationRecord
  
  validates :phone_number, format: { with: /(0)(9)\d{8}/}

  def generate_pin
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save
  end


  def twilio_client
    Twilio::REST::Client.new('ACd1ddc0ae6cb57f040340cd6b205a284e', '1bc8ca6228ee5625cf1abc35792eab51')
  end

  # 這裡面的to phone_number ?? 是什麼？
  def send_pin
    twilio_client.messages.create(
      to: "+886#{self.phone_number}",
      from: '+16144125358',
      body: "Your PIN is #{pin}"
    )
  end

  def send_message(phone_number, message)
    twilio_client.messages.create(
      to: "+886#{phone_number}",
      from: '+16144125358',
      body: message
    )
  end

  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end    

  # def self.times
  #   where("phone_number = ?" , @phone_number.phone_number.to_s).size
  # end

end
