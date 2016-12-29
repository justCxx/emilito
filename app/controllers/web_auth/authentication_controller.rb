require 'web_auth/json_web_token'

module WebAuth
  class AuthenticationController < ActionController::API
    respond_to :json

    # POST /auth/auth_user
    def user_auth
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        render json: payload(user), status: :ok
      else
        render json: {}, status: :forbidden
      end
    end

    private

    def payload(user)
      data = { id: user.id, email: user.email }
      {
        auth_token: WebAuth::JsonWebToken.encode(data),
        user: data
      }
    end
  end
end
