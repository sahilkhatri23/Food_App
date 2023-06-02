class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveRecord::RecordInvalid, :with => :invalid_message

  private

  def authenticate_user!
    token = request.headers[:token] || params[:token]
    @current_user = User.find_for_database_authentication(authentication_token: token)
  end

  def record_not_found
    render  json: { error: "no franchise or menu item was found with id." }, status: :not_found
  end

  def invalid_message
    render  json: { error: "can't be blank" }, status: :unprocessable_entity
  end
end
