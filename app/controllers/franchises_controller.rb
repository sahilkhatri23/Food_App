class FranchisesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication, :except => [:show, :index, :showAllFranchise]
  before_action :find_franchise, only: [:update, :destroy]

  def index
      franchises = current_user.franchises
      render json: franchises, status: :ok
  end

  def showAllFranchise
    franchises = Franchise.all
    render json: franchises, status: :ok
  end

  def show
    franchise = Franchise.find_by(location: params[:location])
    if franchise.present?
      render json: franchise
    else
      render json: {message: "record not found!"}
    end
  end

  def create
    franchise = current_user.franchises.create(franchise_params)
    render json: franchise
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
    @franchise = Franchise.find(params[:id])
  end

  def check_authentication
    if current_user.role == "customer"
      return render json: {message: "you're not an authorized person!"}
    end
  end
end

