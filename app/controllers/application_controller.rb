class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User

  private

  def authenticate_user!
    token = request.headers[:token] || params[:token]
    @current_user = User.find_for_database_authentication(authentication_token: token)
  end

end
