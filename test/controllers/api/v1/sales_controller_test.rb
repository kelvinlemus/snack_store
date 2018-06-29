require "test_helper"
# require "pry-rescue/minitest"

module Api
  module V1
    class SalesControllerTest < ActionDispatch::IntegrationTest
      def test_create
        cheetos = Product.create!(name: "Cheetos", sale_price: 0.60, stock_quantity: 10)
        doritos = Product.create!(name: "Doritos", sale_price: 0.75, stock_quantity: 20)

        options = {
          data: {
            customer_id: common_user.id,
            items: [
              { product_id: cheetos.id, quantity: 2 },
              { product_id: doritos.id, quantity: 5 }
            ]
          }
        }

        token = token_for common_user
        post api_v1_sales_url, params: options, headers: { "HTTP_AUTHORIZATION" => "Bearer #{token.token}" }
        assert_response :created

        sale = Sale.last
        assert_equal common_user, sale.customer
        assert 2, sale.items.count
        assert sale.items.exists?(product_id: cheetos.id, quantity: 2)
        assert sale.items.exists?(product_id: doritos.id, quantity: 5)

        cheetos.reload
        assert_equal 8, cheetos.stock_quantity

        doritos.reload
        assert_equal 15, doritos.stock_quantity
      end
    end
  end
end
