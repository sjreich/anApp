class User < ActiveRecord::Base
  has_secure_password
  before_save {self.email = self.email.downcase}
  validates :name,  presence: true,
                    length: {maximum: 50}

  email_regex = /\A[\w+\-._]+@[\w\d.\-]+\.[a-z]+\z/
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: {with: email_regex}


end
