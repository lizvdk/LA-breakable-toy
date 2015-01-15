class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { in: 3..20 }
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/,
                                 message: "only allows letters and numbers" }

  has_many :reports,
           dependent: :destroy

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      short_name = data["name"].slice!(0..8)
      user = User.create(username: "user#{User.all.last.id + 1}",
        email: data["email"],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
