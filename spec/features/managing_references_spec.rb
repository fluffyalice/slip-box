require 'rails_helper'

describe 'Managing references' do
    specify 'I can access the references creation page' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/references'
        click_link 'New Reference'
        expect(page).to have_content 'New Reference'
    end

    specify 'I can cancel a reference creation' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/references/new'
        click_link 'Cancel'
        expect(page).to have_content 'Reference Manager'
    end

    specify 'I can create a reference' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/references/new'
        fill_in 'Author', with: 'Orwell, G.,'
        fill_in 'Year', with: '1948'
        fill_in 'Title', with: '1984'
        fill_in 'Url', with: 'https://knowyourmeme.com/memes/pressing-a-boot-on-your-own-head'
        fill_in 'Info', with: 'you wouldnt get it'
        click_button 'Create Reference'
        expect(page).to have_content 'Orwell'
    end

    specify 'I can create and delete a reference' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/references/new'
        fill_in 'Author', with: 'Orwell, G.,'
        fill_in 'Year', with: '1948'
        fill_in 'Title', with: '1984'
        fill_in 'Url', with: 'https://knowyourmeme.com/memes/pressing-a-boot-on-your-own-head'
        fill_in 'Info', with: 'you wouldnt get it'
        click_button 'Create Reference'
        click_link class: 'btn-danger'
        expect(page).to_not have_content 'Orwell'
    end

    specify 'I can create and edit a reference' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/references/new'
        fill_in 'Author', with: 'Orwell, G.,'
        fill_in 'Year', with: '1948'
        fill_in 'Title', with: '1984'
        fill_in 'Url', with: 'https://knowyourmeme.com/memes/pressing-a-boot-on-your-own-head'
        fill_in 'Info', with: 'you wouldnt get it'
        click_button 'Create Reference'
        click_link class: 'btn-success mr-1'
        fill_in 'Author', with: 'new author'
        click_button 'Update Reference'
        expect(page).to have_content 'new author'
    end
end