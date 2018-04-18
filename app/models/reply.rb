class Reply < ApplicationRecord

  belongs_to :post, counter_cache: true, optional: true
  belongs_to :user, optional: true
  
end
