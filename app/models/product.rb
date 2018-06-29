class Product < ApplicationRecord
  # associations
  has_many :price_changelogs,
    -> () { where("#{ProductChangelog.table_name}.attribute_name = ?", "sale_price") },
    class_name: "ProductChangelog"
  has_many :likes, class_name: "ProductLike"
end
