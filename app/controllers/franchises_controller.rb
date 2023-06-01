class FranchisesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication, :except => [:show_all_franchise]
  before_action :find_franchise, only: [:update, :destroy]

  def index
    franchises = current_user.franchises
    if franchises.blank?
        render json: {message: "create an franchise."}
    else
      render json: franchises, status: :ok
    end
  end

  def show_all_franchise
    franchises = Franchise.all
    if franchises.blank?
      render json: {message: "franchise not found on your location!"}
    else
      render json: franchises, status: :ok
    end
  end

  def show
    if current_user.role == "owner"
      franchise = current_user.franchises.find(params[:id])
    render json: franchise
  end

  def create
    franchise = current_user.franchises.create(franchise_params)
    render json: franchise, status: :ok
  end

  def update
    @franchise.update(franchise_params)
    render json: @franchise, status: :ok
  end

  def destroy
    @franchise.destroy
    render json: {message: "you destroyed an franchise!"}, status: :ok
  end

  private

  def franchise_params
    params.permit(:name, :description, :address, :location)
  end

  def find_franchise
    @franchise = current_user.franchises.find(params[:id])
  end

  def check_authentication
    if current_user.role == "customer"
      return render json: {message: "you're not an authorized person!"}
    end
  end
end


