module Api
  module V1
    module Sales
      class SaleSerializer < ActiveModel::Serializer
        attributes :id, :customer_id
        has_many :items, serializer: SaleItemSerializer
      end
    end
  end
end