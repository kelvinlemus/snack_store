class ProductLike < ApplicationRecord
  # associations
  belongs_to :product, counter_cache: :likes_count
end
