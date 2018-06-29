module Api
  module V1
    module Sales
      class SaleItemSerializer < ActiveModel::Serializer
        attributes :id, :product_id, :quantity
      end
    end
  end
end