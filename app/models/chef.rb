class Chef < ActiveRecord::Base
  # callback
  before_save { self.email = email.downcase }   # downcase email before storing to database
  # validation
  validates :chefname, presence: true, length: { minimum: 3, maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # /\A[^@]+@[^@]+\z/
  validates :email, presence: true, length: { maximum: 105 },
                                    uniqueness: { case_sensitive: false },
                                    format: { with: VALID_EMAIL_REGEX }
end