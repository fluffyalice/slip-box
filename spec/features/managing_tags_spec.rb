require 'rails_helper'

describe 'Managing tags' do
    specify 'I can access the tags creation page' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/tags'
        click_link 'New Tag'
        expect(page).to have_content 'New Tag'
    end

    specify 'I can cancel a tag creation' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/tags/new'
        click_link 'Cancel'
        expect(page).to have_content 'Tag Manager'
    end

    specify 'I can create a tag' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/tags/new'
        fill_in 'Tag name', with: 'exampletag'
        click_button 'Create Tag'
        expect(page).to have_content 'exampletag'
    end

    specify 'I can create and delete a tag' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/tags/new'
        fill_in 'Tag name', with: 'exampletag'
        click_button 'Create Tag'
        click_link class: 'btn-danger'
        expect(page).to_not have_content 'exampletag'
    end

    specify 'I can create and edit a tag' do
        user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
        login_as(user, :scope => :user)
        visit '/tags/new'
        fill_in 'Tag name', with: 'exampletag'
        click_button 'Create Tag'
        click_link class: 'btn-success mr-1'
        fill_in 'Tag name', with: 'exampletag-changed'
        click_button 'Update Tag'
        expect(page).to have_content 'exampletag-changed'
    end
end