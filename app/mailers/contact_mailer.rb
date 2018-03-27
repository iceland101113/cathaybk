class ContactMailer < ApplicationMailer

  def say_hello_to(user)
    @user = user
    mail to:@user.email, subject:"歡迎加入國泰!!"
  end

end
