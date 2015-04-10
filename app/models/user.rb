class User < ActiveRecord::Base
	before_save { self.email = email.downcase } #before_save для того чтобы принудить Rails переводить в нижний регистр email атрибут перед сохранением пользователя в базу данных,
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i #обеспечивает допустимость адресов электронной почты соответствующих образцу, все остальные будут считаться недопустимыми.
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	has_secure_password
	before_save { email.downcase! }
  	validates :password, length: { minimum: 6 }
end
