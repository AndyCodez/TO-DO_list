class User < ApplicationRecord
  before_save :downcase_email
  REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: REGEX_EMAIL },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

  private

    #Converts email to all lowercase
    def downcase_email
      self.email = email.downcase
    end
end
