class Sale < ApplicationRecord
  # associations
  belongs_to :customer, class_name: "User"
  has_many :items, class_name: "SaleItem"
end
