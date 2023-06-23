require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'Sam', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/256/User-icon.png',
                         bio: 'Teacher from Poland.', posts_counter: 1)
    @user2 = User.create(name: 'John', photo: 'https://example.com/john.jpg',
                         bio: 'Developer from USA.', posts_counter: 3)
    visit users_path
  end

  scenario 'I can see the username, profile picture, and number of posts for each user' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content(@user1.posts_counter)

    expect(page).to have_content(@user2.name)
    expect(page).to have_selector("img[src='#{@user2.photo}']")
    expect(page).to have_content(@user2.posts_counter)
  end
  
  scenario 'When I click on a user, I am redirected to their show page' do
    visit users_path
    click_link @user1.name
    expect(page).to have_current_path(user_path(@user1))
    expect(page).to have_content(@user1.name)
    expect(page).to have_css("img[src='#{@user1.photo}']")
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end
end
