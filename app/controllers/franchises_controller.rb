class FranchisesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication, :except => [:show, :index]

  def index
    @franchise = Franchise.all
    render json: @franchise
  end

  def show
    @franchise = Franchise.find_by(location: params[:location])
    render json: @franchise
  end

  def create
    @franchise = Franchise.create(name: params[:name], description: params[:description], address: params[:address], location: params[:location], user_id: current_user.id)
    render json: @franchise
  end

  def update
    @franchise = Franchise.find(params[:id])
    @franchise.update( name: params[:name], description: params[:description], address: params[:address], location: params[:location])
    render json: @franchise, status: :ok
  end

  def destroy
    @franchise = Franchise.all
    @franchise = Franchise.find(params[:id])
    @franchise.destroy
    render json: {message: "you destroyed an franchise!"}, status: :ok
  end

  private

  def check_authentication
    if current_user.role == "customer"
      return render json: {message: "you're not an authorized person!"}
    end
  end
end

