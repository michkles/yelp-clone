require 'rails_helper'

feature 'restaurants' do

  context 'no restauranrs have been added' do
    scenario 'shuold display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'NOOO RESTAURANTS EVER!!!'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Dandos')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Dandos'
      expect(page).not_to have_content 'NOOO RESTAURANTS EVER!!!'
    end
  end

end
