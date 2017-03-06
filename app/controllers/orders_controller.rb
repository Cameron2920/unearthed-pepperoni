class OrdersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    respond_with Order.outstanding_orders, :represent_with => OrdersRepresenter
  end

  def order_arrived
    order = Order.find_by_id(params[:id])

    if order.nil?
      head :not_found
    else
      order.update(:arrived_at => DateTime.now)
      render json: {}
    end
  end
end
