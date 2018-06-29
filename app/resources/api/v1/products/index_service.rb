module Api
  module V1
    module Products
      class IndexService < Base::Service
        def process
          products = ::OrderedEstateQuery.new(Product.all, params).all.page(params[:page]).per(25)
          self.result = {
            "response" => { data: serialize_products(products) },
            "status" => :ok
          }
        end

        def serialize_products(products)
          ActiveModelSerializers::SerializableResource.new(products, each_serializer: ProductSerializer).as_json
        end
      end
    end
  end
end