class AuthorizeApiRequest
  prepend SimpleCommand

    def initialize(headers = {})
    	 @headers = headers
    end

    def call
    	user
  	end

  ####################
  private 
  ####################
  attr_reader :headers

  	def user
  		@user ||= Api::User.find(decoded_auth_token[:user_id]) if decoded_auth_token 
 	 	@user || (errors[:token] || errors.add(:token, 'Invalid token') )&& nil 
	end

	#decode Token
	def decoded_auth_token
    	@decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  	end

  	#fetch the Authorization header
  	def http_auth_header 
  		if headers['Authorization'].present? 
  			return headers['Authorization'].split(' ').last
  		else
  			errors.add(:token, 'Missing token') 
  		end
  	 	nil
  	end 

end