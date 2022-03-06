require 'rails_helper'

describe 'Logging in' do
    specify 'I can log in using my credentials' do
        visit '/users/sign_in'
        user = User.create!(:username => 'test', :password => 'password', :email => 'test@example.com')
        fill_in 'Username', with: 'test'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        expect(page).to have_content 'Home'
    end
end