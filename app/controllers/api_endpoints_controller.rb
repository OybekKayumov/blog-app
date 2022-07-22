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

  def new_comment
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params.merge(author: current_user))
    if @comment.save
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
