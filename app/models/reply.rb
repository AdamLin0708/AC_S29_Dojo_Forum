class Reply < ApplicationRecord

  belongs_to :post, counter_cache: true, optional: true
  belongs_to :user, counter_cache: true, optional: true
  
end
