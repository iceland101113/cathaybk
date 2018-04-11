class PhoneNumbersController < ApplicationController

  def new
    @phone_number = PhoneNumber.new
  end

  def create
    @phone_number = PhoneNumber.new(phone_params)

    if PhoneNumber.where("phone_number = ?" , @phone_number.phone_number).size >= 100
      redirect_to root_path, notice:'登入操過次數'
    else
    pin = rand(0000..9999).to_s.rjust(4, "0")
    @phone_number.pin = pin
      if @phone_number.save
        login(@phone_number)
      else
        render :new, notice:'填入號碼有誤' 
      end

    end   
  end

  def verify
    if current_phone.pin ==  params[:pin]
      redirect_to basic_path, notice:'驗證成功'
    else
      redirect_to root_path, notice:'填入號碼有誤'
    end
  end

  private

  def phone_params
    params.require(:phone_number).permit(:phone_number, :pin, :verified)
  end

end
