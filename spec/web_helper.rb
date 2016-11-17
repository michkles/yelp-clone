def sign_up
  User.create(email: 'bla@bla.com', password: 'blabla1')
end

def sign_in
  visit('/users/sign_in')
  fill_in 'Email', with: 'bla@bla.com'
  fill_in 'Password', with: 'blabla1'
  click_button 'Log in'
end
