class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication, :except => [:show, :index]

  def index
    menu_items = MenuItem.all
    render json: menu_items
  end

  def show
    menu_item = MenuItem.find_by(dish_name: params[:dish_name])
    if menu_item.present?
      render json: menu_item
    else
      render json: {message: "record not found!"}
    end
  end

  def create
    franchise = Franchise.find(params[:franchise_id])
    menu_item = franchise.menuItems.create(menu_item_params)
    render json: menu_item
  end

  private

  def menu_item_params
    params.permit(:dish_name, :price, :quantity)

  end
end
