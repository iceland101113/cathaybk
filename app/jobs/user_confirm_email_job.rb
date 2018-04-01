class UserConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    @user = user
   ContactMailer.say_hello_to(@user).deliver_now
  end
end
