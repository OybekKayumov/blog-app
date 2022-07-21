require 'rails_helper'

RSpec.describe 'PostsShowPages', type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:each) do
    @user = create(:user, name: 'James')
    login_as @user
    @other_user = create(:user, name: 'Jane')
    (1..6).each do |n|
      post = create(:post, user_id: @other_user.id, title: "Post #{n}")
      post.update_posts_counter(@other_user)
    end
    @other_user.posts.each do |post|
      comment = create(:comment, post_id: post.id, user_id: @user.id)
      comment.update_comments_counter(post)
    end
    @post = @other_user.posts.first
    visit "/users/#{@other_user.id}/posts/#{@post.id}"
  end

  describe 'Page content' do
    it 'should have name of who wrote the post' do
      expect(page).to have_content(@other_user.name)
    end
    it "should display a posts's title" do
      expect(page).to have_content(@post.title)
    end
    it "should display a posts's body" do
      expect(page).to have_content(@post.text)
    end
    it "should display a post's comments count" do
      expect(page).to have_content("Comments: #{@post.comments_counter}")
    end
    it "should display a post's likes count" do
      expect(page).to have_content("Likes: #{@post.likes_counter}")
    end
    it 'should display username of each commentor on a post' do
      expect(page).to have_content("#{@user.name}:")
    end
    it 'should display username of each commentor on a post' do
      comment = @post.comments.where(user_id: @user).first
      expect(page).to have_content(comment.text)
    end
  end
end
