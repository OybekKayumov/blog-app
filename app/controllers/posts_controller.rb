class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = Post.includes(:user).where(user_id: @user.id).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to "/users/#{@post.author.id}/posts/#{@post.id}"
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
    @post = Post.includes(:author, comments: [:author]).find(params[:id])
    @comment = Comment.where(post_id: @post.id).order(created_at: :desc)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find(post.user_id)
    user.posts_counter -= 1
    post.destroy
    user.save
    flash[:success] = 'You have deleted this post successfully!'
    redirect_to user_path(current_user.id)
    authorize! :destroy, @post
  end
end
