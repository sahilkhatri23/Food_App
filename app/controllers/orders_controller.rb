class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication_customer
  before_action :check_orders, only: [:show, :update, :destroy]

  def index
    order = current_user.orders.all
    render json: order
  end

  def show
    render json: @order
  end

  def create
    order = Order.create(order_params)
    render json: order
  end

  def update
    order = @order.update(order_params)
    render json: {message: "order updated."}
  end

  def destroy
    @order.destroy
    render json: {message: "order deleted!"}, status: :ok
  end

  private

  def order_params
    params.permit(:user_id, :menu_item_id)
  end

  def check_authentication_customer
    if current_user.role == "owner"
      return render json: {message: "you're signed in as owner."}
    end
  end

  def check_orders
    begin
      @order = current_user.orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      message = "no orders was found with this id."
      render  json: { error: message }, status: :not_found
    end
  end
end
