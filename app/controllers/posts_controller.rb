class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = Post.where(user_id: @user.id).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to "/users/#{@post.user.id}/posts/#{@post.id}"
    else
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def show
    @current_user = current_user
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.where(post_id: @post.id).order(created_at: :desc)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
