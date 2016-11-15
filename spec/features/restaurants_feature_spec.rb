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

  context 'view a restaurant' do
    let!(:doubles){ Restaurant.create(name:'Frank Doubles') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Frank Doubles'
      expect(page).to have_content 'Frank Doubles'
      expect(current_path).to eq("/restaurants/#{doubles.id}")
    end
  end

  context 'edit a restaurant' do
    let!(:doubles){ Restaurant.create(name:'Frank Doubles') }

    scenario 'lets a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Frank Doubles'
      fill_in 'Name', with: 'Frank Doubles'
      fill_in 'Description', with: 'The best doubles in Trinidad!'
      click_button 'Update Restaurant'
      expect(page).to have_content('Frank Doubles')
      expect(page).to have_content('The best doubles in Trinidad!')
      expect(current_path).to eq("/restaurants")
    end
  end

  context 'delete a restaurant' do
    before { Restaurant.create(name: 'Frank Doubles', description: 'The best doubles in Trinidad!') }

    scenario 'lets a user delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete Frank Doubles'
      expect(page).to have_content 'Restaurant deleted'
      expect(page).not_to have_content 'Frank Doubles'
    end
  end
end
