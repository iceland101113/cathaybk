class UserConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    @user = user
    mail to:@user.email, subject:"歡迎加入國泰!!"
  end
end
