class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication_customer, except: [:show]
  before_action :load_order, only: [:update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :check_orders

  def index
    order = current_user.orders
    if order.blank?
      render json: {error: "ordered list is empty!"}
    else
      render json: order, status: :ok
    end
  end

  def show
    if current_user.role == "owner"
      order = Order.find(params[:id])
      render json: order
    else
      render json: {message: "you're not allowed to show orders!"}
    end
  end

  def create
    order = current_user.orders.create(order_params.merge(order_time: DateTime.now))
    render json: order, status: :created
  end

  def update
    @order.update(order_params)
    render json: @order, status: :ok
  end

  def destroy
    @order.destroy
    render json: {message: "order deleted!"}, status: :ok
  end

  private

  def order_params
    params.permit(:menu_item_id, :franchise_id)
  end

  def check_authentication_customer
    if current_user.role == "owner"
      return render json: {message: "you're signed in as owner."}
    end
  end

  def load_order
    @order = current_user.orders.find(params[:id])
  end

  def check_orders
    render  json: { error: "no order was found with this id." }, status: :not_found
  end
end

