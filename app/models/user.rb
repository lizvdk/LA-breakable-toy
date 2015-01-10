class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { in: 3..20 }
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/,
                                 message: "only allows letters and numbers" }

  has_many :reports,
           dependent: :destroy
end
