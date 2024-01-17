# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, dependent: :destroy
  has_many :categories, through: :expenses
  has_many :group_entities, through: :expenses

  # Custom validations
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 },
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'is not a valid email address' }

  # Password validation
  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\\/-]).*\z/,
                                 message: 'must contain at least one letter, one number, and one special character' }
end
