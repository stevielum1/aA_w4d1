class UsersController < ApplicationController
  def index
    # render plain: "I'm in the index action!"
    @users = User.all
    render json:@users
  end
  def create
    user = User.new(params.require(:user).permit(:name, :email))
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end
  def show
    # user = User.find(params[:id])
    user = User.find_by(id: params[:id])
    # render json: params
    if user
      render json: user
    else
      # render jason: user.errors.full_messages, status: 404
      render plain:'User not found', status: 404
    end
  end
  
  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: user
    else 
      render json: user.errors.full_messages, status:422
      # render plain:'User not found', status: 404
    end
  end
  
  def destroy
    user = User.find(params[:id])
    if user.destroy()
      render json: user
    else
      render plain:'User not find', status: 404
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
  
end