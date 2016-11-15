require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Add a restaurant')
    end
  end

  context 'restaurants have been added' do
    scenario 'restaurant is displayed' do
      Restaurant.create(name: 'Frank Doubles')
      visit '/restaurants'
      expect(page).to have_content('Frank Doubles')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating a resturant' do
    scenario 'user can create a resturant using a form and see it listed' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Frank Doubles'
      click_button 'Create Restaurant'
      expect(page).to have_content('Frank Doubles')
      expect(page).not_to have_content('No restaurants yet')
      expect(current_path).to eq('/restaurants')
    end
  end
end
