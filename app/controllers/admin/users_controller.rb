class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).all
  end

  def index
    @users = User.all
  end
end
