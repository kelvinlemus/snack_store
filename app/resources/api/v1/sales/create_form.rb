module Api
  module V1
    module Sales
      class CreateForm < Base::Form
        property :customer_id

        validates :customer_id, presence: true

        collection :items, populator: :item_populator! do
          properties :product_id, :quantity
          validates :product_id, :quantity, presence: true
        end

        def item_populator!(collection:, index:, **)
          if (item = collection[index])
            item
          else
            collection.insert(index, SaleItem.new)
          end
        end
      end
    end
  end
end