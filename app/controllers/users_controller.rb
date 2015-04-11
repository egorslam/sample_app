class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id]) # params для получения id пользователя
  end

 def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    
    if @user.save
    	sign_in @user  #аутентификация после регистрации 
    	flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
