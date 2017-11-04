# define a command class
class AuthenticateUser
  # put SimpleCommand before the class' ancestors chain
  prepend SimpleCommand

  # optional, initialize the command with some arguments
  def initialize(email, password)
    @email = email
    @password = password
  end

  # mandatory: define a #call method. its return value will be available
  #            through #result
  def call 
    JsonWebToken.encode(user_id: user.id) if user
  end

  ####################
  private 
  ####################
  attr_accessor :email, :password

  def user
    user = Api::User.find_by_email(email) 
    return user if user && user.authenticate(password)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end

end