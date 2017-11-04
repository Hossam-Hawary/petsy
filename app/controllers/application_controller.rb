class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_request
  skip_before_action :authenticate_request, only: :home
  attr_reader :current_user

  def home
  	 render :json => {home:true}
  end

###################
  private
###################

  def authenticate_request
  	command = AuthorizeApiRequest.call(request.headers)
  	@current_user = command.result
  	render json: { error: command.errors  }, status: 401 unless @current_user
  end

end
