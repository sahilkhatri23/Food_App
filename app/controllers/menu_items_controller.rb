class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication, :except => [:show_all_menu_items, :show]
  before_action :load_franchise, :except => [:show_all_menu_items, :show]
  before_action :load_franchise_for_customer, only: [:show, :show_all_menu_items]

  def index
    menu_items = @franchise.menu_items.all
    render json: menu_items, status: :ok
  end

  def show
    menu_item = @franchise.menu_items.find(params[:id])
    render json: menu_item, status: :ok
  end

  def show_all_menu_items
    menu_items = @franchise.menu_items.all
    render json: menu_items, status: :ok
  end

  def create
    byebug
    menu_item = @franchise.menu_items.create(menu_item_params)
    render json: menu_item, status: :created
  end

  def update
    @menu_item.update(menu_item_params)
    render json: @menu_item, status: :updated
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
    begin
      franchise = current_user.franchises.find(params[:franchise_id])
      @menu_item = franchise.menu_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      message = "no franchise or menu item was found with id."
      render  json: { error: message }, status: :not_found
    end
  end

  def load_franchise_for_customer
    @franchise = Franchise.find(params[:franchise_id])
  end
end
