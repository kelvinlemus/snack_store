class Api::V1::ProductsController < Api::V1::ApplicationController
  before_action :doorkeeper_authorize!, only: [:create, :destroy, :like, :update_price]

  def index
    result = Api::V1::Products::IndexService.(params)
    render json: result["response"], status: result["status"]
  end

  def create
    result = Api::V1::Products::CreateService.(params)
    render json: result["response"], status: result["status"]
  end

  def destroy
    result = Api::V1::Products::DestroyService.(params)
    render json: result["response"], status: result["status"]
  end

  def like
    result = Api::V1::Products::LikeService.(params, { current_user: current_resource_owner })
    render json: result["response"], status: result["status"]
  end

  def update_price
    result = Api::V1::Products::UpdatePriceService.(params, { current_user: current_resource_owner })
    render json: result["response"], status: result["status"]
  end
end
