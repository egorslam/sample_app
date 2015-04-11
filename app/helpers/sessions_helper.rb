module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
	end

	def signed_in?
   		 !current_user.nil? #проверка для шаблонов
  	end

	def current_user=(user)
    	@current_user = user
    end

    def current_user
	    remember_token = User.encrypt(cookies[:remember_token])
	    @current_user ||= User.find_by(remember_token: remember_token) #ызывает метод find_by при первом вызове которого вызывается current_user, но при последующих вызовах возвращается @current_user без обращения к базе данных
  end
   def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
