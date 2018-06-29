module Api
  module V1
    module Products
      class Form < Base::Form
        property :sale_price
        validates :sale_price, presence: true
      end

      class UpdatePriceService < Base::Service
        def process
          model = Product.find_by_id(params[:id])
          form = Form.new(model)

          if form.validate(params[:data]) && form.save
            create_price_changelog_for(form.model)

            self.result = {
              "response" => {
                data: serialize_model(form.model, serializer: ProductSerializer)
              },
              "status" => :ok
            }
          else
            self.result = {
              "response" => { errors: form.errors.messages },
              "status" => :unprocessable_entity
            }
          end
        end

        def create_price_changelog_for(product)
          changes = product.previous_changes["sale_price"]
          return unless changes.present?

          changelog = product.price_changelogs.new(attribute_name: "sale_price")
          changelog.user = self.options[:current_user]
          changelog.old_value = changes[0]
          changelog.new_value = changes[1]
          changelog.save
        end
      end
    end
  end
end