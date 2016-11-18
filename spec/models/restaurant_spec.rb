require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create(email: 'bla@bla.com', password: 'qwerty' )
    restaurant_1 = user.restaurants.build(name: "The Alis' Tavern")
    restaurant_1.save
    restaurant_2 = user.restaurants.build(name: "The Alis' Tavern")
    expect(restaurant_2).to have(1).error_on(:name)
  end
end
