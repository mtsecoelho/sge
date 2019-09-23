class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :login, presence: true, uniqueness: true
    #validates :password, presence: true

    def to_s
        self.login + " - " + self.token
    end
end
