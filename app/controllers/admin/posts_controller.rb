class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    redirect_to admin_posts_path, notice: '投稿を削除しました。' if post.destroy
  end
end
