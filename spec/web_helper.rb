def sign_up
  User.create(email: 'bla@bla.com', password: 'blabla1')
  User.create(email: 'aaa@aaa.com', password: 'blabla1')
end

def sign_in
  visit('/users/sign_in')
  fill_in 'Email', with: 'bla@bla.com'
  fill_in 'Password', with: 'blabla1'
  click_button 'Log in'
end

def sign_in_user2

  visit('/users/sign_in')
  fill_in 'Email', with: 'aaa@aaa.com'
  fill_in 'Password', with: 'blabla1'
  click_button 'Log in'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
