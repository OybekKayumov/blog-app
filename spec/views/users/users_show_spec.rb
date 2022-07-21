require 'rails_helper'

RSpec.describe 'UserShowPages', type: :system do
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
    visit "/users/#{@other_user.id}"
  end

  describe 'Page content' do
    it "should have other user's profile picture" do
      expect(page).to have_css("img[src*='#{@other_user.photo}']")
    end
    it 'should have username of other user' do
      expect(page).to have_content(@other_user.name)
    end
    it 'should have number of posts of other user' do
      expect(page).to have_content("Number of posts: #{@other_user.posts_counter}")
    end
    it "should display other user's bio" do
      expect(page).to have_content(@other_user.bio)
    end

    context "Other user's first three posts" do
      it 'should display first three posts of other user' do
        expect(page).to have_content(@other_user.posts[0].title)
      end
      it 'should display first three posts of other user' do
        expect(page).to have_content(@other_user.posts[1].title)
      end
      it 'should display first three posts of other user' do
        expect(page).to have_content(@other_user.posts[2].title)
      end
      it 'should display first three posts of other user' do
        expect(page).to_not have_content(@other_user.posts[3].title)
      end
    end

    it 'should display a button for showing all the other users posts' do
      expect(page).to have_content('See all posts')
    end
  end

  describe 'Interactions' do
    it "should redirect to other user's clicked post's show page" do
      first_post = @other_user.posts.first
      click_link(first_post.id.to_s)
      expect(page).to have_current_path("/users/#{@other_user.id}/posts/#{first_post.id}")
    end

    it "should redirect to other user's posts index page" do
      click_link 'See all posts'
      expect(page).to have_current_path("/users/#{@other_user.id}/posts")
    end
  end
end
