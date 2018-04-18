class Post < ApplicationRecord

  mount_uploader :image, PostImageUploader

  validates_presence_of :title, :content
  serialize :categories, Array
  belongs_to :user
  has_many :replies, dependent: :destroy
  
end
