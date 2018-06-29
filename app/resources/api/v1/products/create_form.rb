module Api
  module V1
    module Products
      class CreateForm < Base::Form
        property :code
        property :name
        property :description
        property :sale_price
        property :stock_quantity

        validates :name, :sale_price, :stock_quantity, presence: true
      end
    end
  end
end