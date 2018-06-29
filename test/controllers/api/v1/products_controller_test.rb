require "test_helper"
# require "pry-rescue/minitest"

module Api
  module V1
    class ProductsControllerTest < ActionDispatch::IntegrationTest
      def test_index
        get api_v1_products_url
        assert_response :ok
      end

      def test_create
        options = {
          data: {
            code: "DR01",
            name: "Doritos",
            sale_price: "0.75",
            stock_quantity: 5
          }
        }
        token = token_for common_user

        post api_v1_products_url, params: options, headers: { "HTTP_AUTHORIZATION" => "Bearer #{token.token}" }
        assert_response :created

        product = Product.last
        assert json.has_key?("data")

        assert_equal options[:data][:code], product.code
        assert_equal options[:data][:name], product.name
        assert_equal options[:data][:sale_price], product.sale_price.to_s
        assert_equal options[:data][:stock_quantity], product.stock_quantity

        assert_equal json["data"]["id"], product.id
        assert_equal json["data"]["code"], product.code
        assert_equal json["data"]["name"], product.name
        assert_equal json["data"]["sale_price"], product.sale_price.to_s
        assert_equal json["data"]["stock_quantity"], product.stock_quantity
      end

      def test_destroy
        product = Product.create!(name: "Doritos")
        token = token_for common_user
        delete api_v1_product_url(product), headers: { "HTTP_AUTHORIZATION" => "Bearer #{token.token}" }
        assert_response :ok
        refute Product.exists?(id: product.id)
      end

      def test_like
        product = Product.create!(name: "Doritos")
        token = token_for common_user

        post like_api_v1_product_url(product), headers: { "HTTP_AUTHORIZATION" => "Bearer #{token.token}" }
        assert_response :ok
        product.reload
        assert product.likes.exists?(user_id: common_user.id)
        assert_equal 1, product.likes_count
      end

      def test_update_price
        product = Product.create!(name: "Doritos", sale_price: "0.75")
        token = token_for common_user

        options = {
          data: {
            sale_price: "0.80"
          }
        }
        post update_price_api_v1_product_url(product), params: options, headers: { "HTTP_AUTHORIZATION" => "Bearer #{token.token}" }
        assert_response :ok
        product.reload
        assert_equal 0.80, product.sale_price

        price_changelog = product.price_changelogs.last
        assert_equal common_user, price_changelog.user
        assert_equal "0.75", price_changelog.old_value
        assert_equal "0.8", price_changelog.new_value
      end
    end
  end
end