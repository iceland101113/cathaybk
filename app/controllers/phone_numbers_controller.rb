class PhoneNumbersController < ApplicationController

  def new
    @phone_number = PhoneNumber.new
  end

   def create
    @phone_number = PhoneNumber.new(phone_params)

    if PhoneNumber.where("phone_number = ?" , @phone_number.phone_number).size >= 3
      redirect_to root_path, notice:'登入操過次數'
    else
        pin = rand(0000..9999).to_s.rjust(4, "0")
         @phone_number.pin = pin
      if @phone_number.save
        login(@phone_number)
        puts @phone_number.id
         # @phone_number.generate_pin
         # @phone_number.send_pin
         # session[:phone_number] = @phone_number
      else
        redirect_to root_path, notice:'填入號碼或信箱有誤'
      end

    end   
  end

  def verify
    # @phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
    # @phone_number.verify(params[:pin])
    # if @phone_number.verified == true
    #   redirect_to basic_path, notice:'驗證成功'
    # else
    #   redirect_to root_path, notice:'填入號碼有誤'
    # end
    if current_phone.pin ==  params[:pin]
      redirect_to basic_path, notice:'驗證成功'
    else
      redirect_to root_path, notice:'填入號碼有誤'
    end
  end


  
  def robots
    robots = File.read(Rails.root.join('config', "robots.#{Rails.env}.txt"))
    render plain: robots
  end


  private

  def phone_params
    params.require(:phone_number).permit(:phone_number, :pin, :verified, :email)
  end



end
