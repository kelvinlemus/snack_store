module Api
  module V1
    module Products
      class CreateService < Base::Service
        def process
          model = Product.new
          form = CreateForm.new(model, params[:data])

          if form.save
            self.result = {
              "response" => {
                data: serialize_model(form.model, serializer: ProductSerializer)
              },
              "status" => :created
            }
          else
            self.result = {
              "response" => { errors: {} },
              "status" => :unprocessable_entity
            }
          end
        end
      end
    end
  end
end