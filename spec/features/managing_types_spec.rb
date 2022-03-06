require 'rails_helper'

describe 'Managing types' do
    specify 'I can access the types creation page' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/types'
        click_link 'New Type'
        expect(page).to have_content 'Type name'
    end

    specify 'I can cancel a type creation' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/types/new'
        click_link 'Cancel'
        expect(page).to have_content 'Type Manager'
    end

    specify 'I can create a type' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/types/new'
        fill_in 'Type name', with: 'exampletype'
        click_button 'Create Type'
        expect(page).to have_content 'exampletype'
    end

    specify 'I can create and delete a type' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/types/new'
        fill_in 'Type name', with: 'exampletype'
        click_button 'Create Type'
        click_link class: 'btn-danger'
        expect(page).to_not have_content 'exampletype'
    end

    specify 'I can create and edit a type' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/types/new'
        fill_in 'Type name', with: 'exampletype'
        click_button 'Create Type'
        click_link class: 'btn-success mr-1'
        fill_in 'Type name', with: 'exampletype-changed'
        click_button 'Update Type'
        expect(page).to have_content 'exampletype-changed'
    end

    specify 'I can choose a colour for a type' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/types/new'
        fill_in 'Type name', with: 'exampletype'
        fill_in :color with: '000'
        click_button 'Create Type'
        within_frame
    end
end