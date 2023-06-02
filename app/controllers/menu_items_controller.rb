class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication, :except => [:show_all_menu_items]
  before_action :load_franchise, except: [:show_all_menu_items]
  before_action :load_menu_item, only: [:update, :destroy]

  def index
    menu_items = @franchise.menu_items
    render json: menu_items, status: :ok
  end

  def show
    menu_item = @franchise.menu_items.find(params[:id])
    render json: menu_item, status: :ok
  end

  def show_all_menu_items
    franchise = Franchise.find(params[:franchise_id])
    menu_items = franchise.menu_items
    if current_user.role == "customer"
      render json: menu_items, status: :ok
    else
      render json: {message: "admin can't see full menu."}
    end
  end

  def create
    menu_item = @franchise.menu_items.create!(menu_item_params)
    render json: menu_item, status: :created
  end

  def update
    @menu_item.update!(menu_item_params)
    render json: @menu_item, status: :ok
  end

  def destroy
    @menu_item.destroy
    render json: {message: "you destroyed an item!"}, status: :ok
  end

  private

  def menu_item_params
    params.permit(:dish_name, :price, :quantity)
  end

  def check_authentication
    if current_user.role == "customer"
      return render json: {message: "you're not an authorized person!"}
    end
  end

  def load_franchise
    @franchise = current_user.franchises.find(params[:franchise_id])
  end

  def load_menu_item
    @menu_item = @franchise.menu_items.find(params[:id])
  end
end
