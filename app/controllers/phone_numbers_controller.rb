class PhoneNumbersController < ApplicationController

  def new
    @phone_number = PhoneNumber.new

  end

  def create
    @phone_number = PhoneNumber.find_or_create_by(phone_number: params[:phone_number][:phone_number])
    if @phone_number.save
      @phone_number.generate_pin
      @phone_number.send_pin
      session[:phone_number] = @phone_number
    
      respond_to do |format|
        
        format.js # render app/views/phone_numbers/create.js.erb
      end
    
    else
     
      render :new, notice:'填入號碼有誤'
      
    end
    
  end

  def verify
    @phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
    @phone_number.verify(params[:pin])
    if @phone_number.verified == true
      redirect_to basic_path, notice:'驗證成功'
    else
      render :new, notice:'填入號碼有誤'
    end

  end

end
