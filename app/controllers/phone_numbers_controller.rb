class PhoneNumbersController < ApplicationController

  def new
    @phone_number = PhoneNumber.new
    @pin = rand(0000..9999).to_s.rjust(4, "0")
        
        @phone_number.pin = @pin
        session[:pin] = @pin
  end

  def create
    @phone_number = PhoneNumber.create(phone_number: params[:phone_number])
    

    if PhoneNumber.where("phone_number = ?" , @phone_number.phone_number).size >= 3
      redirect_to root_path, notice:'登入操過次數'

    else

      if @phone_number.save
        # @phone_number.generate_pin
        # @phone_number.send_pin
        session[:phone_number] = @phone_number
        
        
        respond_to do |format|
          
          format.js # render app/views/phone_numbers/create.js.erb
        end
      
      else
        render :new, notice:'填入號碼有誤' 
      end

    end
      
    
    
  end

  def verify
    # @phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
    # @phone_number.verify(params[:pin])

    if session[:pin] ==  params[:pin]
      redirect_to basic_path, notice:'驗證成功'
    else
      redirect_to root_path, notice:'填入號碼有誤'
    end

  end

end
