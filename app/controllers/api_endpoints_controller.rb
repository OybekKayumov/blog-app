class ApiEndpointsController < ApplicationController
  def user_posts    
    @user = User.find(params[:user_id])
    @posts = @user.posts 
    render json: @posts, status: :ok    
  end   
end