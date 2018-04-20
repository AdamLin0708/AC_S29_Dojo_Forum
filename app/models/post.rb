class Post < ApplicationRecord

  mount_uploader :image, PostImageUploader

  validates_presence_of :title
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :setted_categories, through: :post_categories, source: :category
  
end
