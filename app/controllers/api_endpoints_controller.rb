class ApiEndpointsController < ApplicationController
  def user_posts
    @user = User.find(params[:user_id])
    @posts = @user.posts
    render json: @posts, status: :ok
  end

  def user_post_comments
    @comments = Comment.find_by(post_id: params[:post_id])
    render json: @comments, status: :ok
  end
end
