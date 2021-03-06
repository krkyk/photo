class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    @comments = @post.comments.order(created_at: 'DESC').all
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    @comments = @post.comments.order(created_at: 'DESC').all
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
