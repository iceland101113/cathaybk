class ContactMailer < ApplicationMailer

  def say_hello_to(user, message)
    @user = user
    @message = message
    mail to:@user.email, subject: message
  end

  def say_remind_to(user, message)
    @user = user
     @message = message
    mail to:@user.email, subject: message
  end

end
