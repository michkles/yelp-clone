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

describe 'reviews' do
  describe 'build with user' do
    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end
end
