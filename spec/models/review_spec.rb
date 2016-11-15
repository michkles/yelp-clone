require 'rails_helper'

describe Review, type: :model do
  it 'is impossibile to rate more than 10' do
    review = Review.new(rating: 11)
    expect(review).to have(1).error_on(:rating)
  end
end
