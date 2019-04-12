# frozen_string_literal: true

class User < ApplicationRecord
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  
  has_secure_password
  # Provides user authentication features on the model
  # that it is called in. It requires a column named
  # 'password_digest' and the gem 'bcrypt'
  # - It will add two attribute accessors for
  # 'password' and 'password_confirmation'
  # - It will add  a presence validation for the
  # 'password' field.
  # - It will save passwords assigned to 'password'
  # using bcrypt to hash and store it in the
  # 'password_digest' column, meaning we will never
  # store plain text passwords.
  # - It will add a method named 'authenticate' to verify
  # a user's password. If called with the correct
  # password, it will return the User, otherwise it
  # will return false.
  # - The attr_accessor 'password_confirmation' is
  # optional. But, if it is present, a validation
  # will verify that it is identical to the 'password'
  # attr_accessor

  # For more details:
   # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password

  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  def full_name
    "#{first_name} #{last_name}".strip
  end
  
end
