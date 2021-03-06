class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, UserAvatarUploader         
  has_many :posts, dependent: :destroy        
  has_many :replies, dependent: :destroy

  def admin?
    self.role == "admin"
  end         
end
