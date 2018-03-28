
class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      
      redirect_to cards_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end


    private


    def user_params
      params.require(:user).permit(:name, :email)
    end
end