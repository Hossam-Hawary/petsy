class Api::AuthenticationController < ApplicationController
      skip_before_action :authenticate_request,:verify_authenticity_token, only: :authenticate

	def authenticate
    	command = AuthenticateUser.call(user_params[:email], user_params[:password])

    	if command.success?
    		 render json: { auth_token: command.result }
    	else
    		render json: { error_messages: command.errors[:user_authentication], params:user_params }, status: :unauthorized
    	end

    end

    def need_auth
    	 render json: { success:true }
    end
    ####################
    private
    #####################
    def user_params
      params.require(:user).permit(:email, :password)
    end

end