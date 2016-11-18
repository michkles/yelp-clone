require 'rails_helper'

feature 'reviewing' do
  let!(:user) {User.create(email: 'bla@bla.com', password: 'blabla1', id: 1)}
  let!(:restaurant) { user.restaurants.build(name: 'KFFC', description: 'whatever')}
  before do
    restaurant.save
  end

  scenario 'displays an average rating for all reviews' do
    sign_up
    sign_in
    leave_review('shit', '1')
    click_link 'Sign out'
    sign_in_user2
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
end

  scenario 'allows users to leave a review using a form' do
    sign_in
    visit '/restaurants'
    click_link 'Review KFFC'
    fill_in "Thoughts", with: "Amazing fried chicken. I would sell my soul for it."
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Amazing fried chicken. I would sell my soul for it.')
  end
end
