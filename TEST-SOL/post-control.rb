class PostsController < ApplicationController
  def index
    @users = User.all
    @user = User.find(params[:user_id])
    @user_posts = @user.posts
  end

  def show
    @users = User.all
    @user = User.find(params[:user_id])
    @user_post = Post.find_by(user_id: params[:user_id], id: params[:id])
  end
end