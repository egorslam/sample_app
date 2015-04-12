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

  	def current_user?(user)
  		user = current_user
  	end

	def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  	end

  	def redirect_back_or(default) #для перенаправления на запрашиваемый URL
  		redirect_to(session[:return_to] || default) #Этот код оценивает session[:return_to] и до тех пор, пока оно не является nil, в противном случае он оценивает заданный дефолтный URL
  		session.delete(:return_to)
  	end

  	def store_location #Метод store_location помещает запрашиваемый URL в переменную session под ключом :return_to, но только для GET запроса (if request.get?). Эт
  		session[:return_to] = request.url if request.get? #request для получения url
  	end

  	def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
