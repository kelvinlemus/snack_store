class Api::V1::SalesController < Api::V1::ApplicationController
  before_action :doorkeeper_authorize!

  def create
    result = Api::V1::Sales::CreateService.(params)
    render json: result["response"], status: result["status"]
  end
end