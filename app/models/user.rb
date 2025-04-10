class User < ApplicationRecord
  has_many :bookings, foreign_key: :renter_id
  has_many :mouettes, foreign_key: :owner_id
  has_many :bookings_as_owner, through: :mouettes, source: :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :last_name, length: { minimum: 2, message: "doit comporter au moins 2 lettres" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP , message: "format incorrect"}
  validates :email, uniqueness: true
  validates :first_name, length: { minimum: 2, message: "doit comporter au moins 2 lettres" }
  after_create :send_welcome_email_now

  private

  def send_welcome_email_now
    MailAdapter::Brevo.new.send_welcome_email_now
  end
end
