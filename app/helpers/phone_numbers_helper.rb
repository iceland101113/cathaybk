module PhoneNumbersHelper

	def login(phone)
    session[:phone] = phone.id    
  end

  def current_phone
    @current_phone ||= PhoneNumber.find_by(id: session[:phone])
  end

end
