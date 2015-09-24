class User < ActiveRecord::Base

  has_secure_password

  before_save {self.email = email.downcase}
  validates :name,  presence: true, 
                    length: {maximum: 50}

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: {maximum: 255}, 
                    format: {with: valid_email_regex },
                    uniqueness: {case_sensitive: false}

  validates :password,  presence: true,
                        length: {minimum: 6}

end
