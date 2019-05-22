class Api::V1::UsersController < Api::ApplicationController
  before_action :authenticate_user!, only: [ :current ]

  def current
    render json: current_user
  end

  def create
    user = User.new user_params

    if user.save
      session[:user_id] = user.id
      render json: {id: user.id}
    else
      render(
        json: { errors: user.errors.messages },
        status: 422 # Unprocessable Entity
      )
    end
  end

  def update
    user = User.find params[:id]
    user.update!(user_params)
    render(
      json: { status: 200 }
    )
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name, 
      :email, 
      :password, 
      :password_confirmation,
      avatars: []
      )
  end
end
