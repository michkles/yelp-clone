require 'rails_helper'


  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Add a restaurant')
    end
  end
feature 'restaurants' do

    let!(:user) {User.create(email: 'bla@bla.com', password: 'blabla1')}
    let!(:restaurant) { user.restaurants.build(name: 'Frank Doubles', description: 'whatever')}
    before do
      restaurant.save
    end
  context 'restaurants have been added' do

    scenario 'restaurant is displayed' do
      visit '/restaurants'
      expect(page).to have_content('Frank Doubles')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating a resturant' do

    scenario "user can't create a restaurant if not signed in" do
      visit('/')
      click_link 'Add a restaurant'
      expect(page).to have_content('Log in')
    end


    scenario 'user can create a resturant using a form and see it listed' do
      visit '/restaurants'
      sign_up
      sign_in
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Frank Triples'
      click_button 'Create Restaurant'
      expect(page).to have_content('Frank Triples')
      expect(page).not_to have_content('No restaurants yet')
      expect(current_path).to eq('/restaurants')
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        sign_up
        sign_in
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end

      scenario 'restaurant name already exists' do
        visit '/restaurants'
        sign_up
        sign_in
        click_link 'Add a restaurant'
        fill_in 'Name', with: "Frank Doubles"
        click_button 'Create Restaurant'
        expect(page).to have_content("Name has already been taken")
      end
    end
  end

  context 'view a restaurant' do

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Frank Doubles'
      expect(page).to have_content 'Frank Doubles'
      expect(current_path).to eq("/restaurants/#{restaurant.id}")
    end
  end

  context 'edit a restaurant' do

    scenario 'lets a user edit a restaurant' do
      sign_in
      visit '/restaurants'
      click_link 'Edit Frank Doubles'
      fill_in 'Name', with: 'Frank Doubles'
      fill_in 'Description', with: 'The best doubles in Trinidad!'
      click_button 'Update Restaurant'
      # click_link 'Frank Doubles'
      expect(page).to have_content('Frank Doubles')
      expect(page).to have_content('The best doubles in Trinidad!')
      expect(current_path).to eq("/restaurants")
    end
  end

  context 'delete a restaurant' do
    before { Restaurant.create(name: 'Frank Doubles', description: 'The best doubles in Trinidad!') }

    scenario 'lets a user delete a restaurant' do
      visit '/restaurants'
      sign_up
      sign_in
      click_link 'Delete Frank Doubles'
      expect(page).to have_content 'Restaurant deleted'
      expect(page).not_to have_content 'Frank Doubles'
    end
  end
end
