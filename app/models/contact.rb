class Contact < ApplicationRecord
    # バリデーション
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :message, presence: true, length: { maximum: 1000 }
  end
