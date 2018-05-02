class Post < ApplicationRecord

  mount_uploader :image, PostImageUploader

  validates_presence_of :title
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :setted_categories, through: :post_categories, source: :category


  def increment(by = 1)
    
    # 功能: 文章瀏覽數counter    

    self.viewed_count ||= 0
    self.viewed_count += by
    self.save
  end
  
end
