module Api
  module V1
    module Products
      class ProductSerializer < ActiveModel::Serializer
        attributes :id, :code, :name, :sale_price, :stock_quantity, :likes_count
      end
    end
  end
end