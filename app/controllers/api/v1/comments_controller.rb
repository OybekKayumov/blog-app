class Api::V1::CommentsController < ApiController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = @user.comments
    respond_to do |format|
      format.json { render json: @comments.to_json, status: :ok }
    end
  end

  def create
    comment = Comment.new(comments_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comments_params
    params.permit(:text, :post_id, :author_id)
  end
end
