module Api
  module V1
    module Products
      class LikeService < Base::Service
        def process
          model = Product.find_by_id(params[:id])
          current_user_id = self.options[:current_user].id

          unless model.likes.exists?(user_id: current_user_id)
            model.likes.create(user_id: current_user_id)
            self.result = {
              "response" => {
                data: serialize_model(model, serializer: ProductSerializer)
              },
              "status" => :ok
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