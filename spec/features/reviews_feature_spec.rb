require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Nandos', description: 'grilled chicken' }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Nandos'
    fill_in "Thoughts", with: 'so good'
    select '10', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so good')
  end
end
