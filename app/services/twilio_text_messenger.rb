class TwilioTextMessenger
  attr_reader :message
 
  def initialize(message)
    @message = message
  end
 
  def call
    @phone_number = "0932130072"
    client = Twilio::REST::Client.new('ACd1ddc0ae6cb57f040340cd6b205a284e', '1bc8ca6228ee5625cf1abc35792eab51')
    client.messages.create({
      from: '+16144125358',
      to: "+886#{@phone_number}",
      body: message
    })
  end
end