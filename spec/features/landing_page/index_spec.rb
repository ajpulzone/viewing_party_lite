require 'rails_helper'

RSpec.describe 'Landing Page' do
  before(:each) do
    @user1 = User.create!(name: 'Chad', email: 'chad1@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user2 = User.create!(name: 'Jessica', email: 'jessica2@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user3 = User.create!(name: 'Fiona', email: 'Fiona3@gmail.com', password: "1234test", password_confirmation: "1234test")
  end

  describe "Landing Page seen by a visitor" do
    it 'should contain title of Viewing Party' do
      visit root_path
      within('#dashboard') do
        expect(page).to have_content('Viewing Party')
      end
    end

    it 'should contain link titled create a new user' do
      visit root_path
    
      expect(page).to have_link('Create A User')
      click_link('Create A User')
      expect(current_path).to eq("/register")
    end

    it 'should NOT contain a list of existing users' do
      visit root_path
      expect(page).to have_no_content(@user1.name)
      expect(page).to have_no_content(@user2.name)
      expect(page).to have_no_content(@user3.name)
    end

    it "if the visitor tries to visit '/dashboard', they should be redirected back to the landing page 
      and there should be a message that says 'You must be logged in'" do
        visit root_path

        expect(page).to have_no_content("You must be logged in")
        visit "/dashboard"
        
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You must be logged in")
    end
  end

  describe "Landing Page seen as a logged in user" do
    it 'if a user is logged in the landing page should contain a list of existing users e-mail addresses' do
      visit login_path

      fill_in :email, with: "chad1@gmail.com"
      fill_in :password, with: "1234test"
      click_button "Login" 

      visit root_path 

      within('#existing_users') do
        expect(page).to have_content(@user1.email)
        expect(page).to have_content(@user2.email)
        expect(page).to have_content(@user3.email)
      end
    end
  end

  it 'should contain a link to go back to the landing page' do
    visit root_path
    within('#dashboard') do
      expect(page).to have_link('Home')
      click_link('Home')
      expect(current_path).to eq(root_path)
    end
  end
end 