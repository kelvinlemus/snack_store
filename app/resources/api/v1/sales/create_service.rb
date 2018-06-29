module Api
  module V1
    module Sales
      class CreateService < Base::Service
        def process
          model = Sale.new
          form = CreateForm.new(model)
          if form.validate(params[:data]) && form.save
            decrease_stock_for(form.model.items)

            self.result = {
              "response" => {
                data: serialize_model(form.model, serializer: SaleSerializer)
              },
              "status" => :created
            }
          else
            self.result = {
              "response" => { errors: form.errors.messages },
              "status" => :unprocessable_entity
            }
          end
        end

        def decrease_stock_for(items)
          items.each do |item|
            product = item.product
            product.stock_quantity -= item.quantity
            product.save
          end
        end
      end
    end
  end
end