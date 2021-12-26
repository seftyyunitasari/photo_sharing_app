class User < ApplicationRecord
	before_validation {email.downcase!}
	has_secure_password
	validates :password, length: {minimum: 6}
end
