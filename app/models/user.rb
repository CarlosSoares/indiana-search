# User ActiveRecord
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company

  # You likely have this before callback set up for the token.
  before_save :ensure_authentication_token

  has_many :projects, through: :company
  has_many :consumers, through: :projects
  has_many :searches, through: :consumers

  accepts_nested_attributes_for :company

  def ensure_authentication_token
    self.authentication_token = generate_authentication_token if authentication_token.blank?
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.find_by(authentication_token: token)
    end
  end
end
