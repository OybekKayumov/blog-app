require 'rails_helper'
RSpec.feature 'User #Show', type: :feature do
  background do
    visit new_user_session_path
    @user1 = User.create(name: 'Sam', bio: 'This is my bio',
                         photo: 'https://steelfoads/', email: 'Sam@gmail.com', password: 'pard', confirmed_at: Time.now)
  end

  scenario 'show number of posts per user' do
    Post.create(title: 'This is post 1', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                author_id: @user1.id)
  end
end
