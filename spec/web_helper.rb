def sign_up_in
  User.create(email: 'mak@o.com', password: '123')
  visit('/')
  click_link 'Sign in'
  fill_in 'Email', with: 'mak@o.com'
  fill_in 'Password', with: '123'
  click_button 'Log in'
end
