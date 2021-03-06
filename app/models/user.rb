class User < ActiveRecord::Base

  before_save {self.email.downcase!}
  validates :name,  presence: true,
                    length: { maximum: 50 }

  email_regex = /\A[\w+_\-.]+@[a-z\d.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: {with: email_regex},
                    uniqueness: {case_sensitive: false}

  has_secure_password

  validates :password,  presence: true,
                        length: {minimum: 6},
                        allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
