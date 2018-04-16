class ContactMailer < ApplicationMailer

  def say_hello_to(current_phone , message)
    @user = current_phone
    @message = message
    mail to:@user.email, subject: message
  end

  def say_remind_to(current_phone, message)
    @user = current_phone
     @message = message
    mail to:@user.email, subject: message
  end

end
