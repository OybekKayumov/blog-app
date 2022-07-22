class Api::V1::PostsController < ApiController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    respond_to do |format|
      format.json { render json: @posts.to_json, status: :ok }
    end
  end
end
