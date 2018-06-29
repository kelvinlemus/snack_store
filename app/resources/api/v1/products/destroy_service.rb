module Api
  module V1
    module Products
      class DestroyService < Base::Service
        def process
          model = Product.find_by_id(params[:id])
          model.destroy
          self.result = {
            "response" => nil,
            "status" => :ok
          }
        end
      end
    end
  end
end