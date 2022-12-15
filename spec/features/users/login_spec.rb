require 'rails_helper'

RSpec.describe 'Login Page' do
  before(:each) do
    @user1 = User.create!(name: 'Chad', email: 'chad1@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user2 = User.create!(name: 'Jessica', email: 'jessica2@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user3 = User.create!(name: 'Fiona', email: 'Fiona3@gmail.com', password: "1234test", password_confirmation: "1234test")
  end

  describe "succesful login" do
    it "the landing page should have a link for 'Log In' that when clicked will take the user to the login page" do
      visit root_path

      within('#dashboard') do
        expect(page).to have_link('Log In')
        click_link('Log In')
        expect(current_path).to eq(login_path)
      end
    end

    it "the login page should have a field for the user to put in their email and password" do
      visit login_path

      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_button("Login")
    end

    it "when a an email and password that match a created user are entered, the user is taken to their
      show page" do
        visit login_path

        fill_in :email, with: "Fiona3@gmail.com"
        fill_in :password, with: "1234test"
        click_button "Login"
        expect(current_path).to eq("/dashboard")
    end
  end 

  describe "unsuccessful login" do
    it "when a an email or password do not match a created user are entered, the the user is redirected
      back to the login page and an error noting invalid credentials is shown on the page" do
      visit login_path
      fill_in :email, with: "Fiona3@gmail.com"
      fill_in :password, with: "pickle"
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Credentials Invalid")

      visit login_path
      fill_in :email, with: "carebear@gmail.com"
      fill_in :password, with: "1234test"
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Credentials Invalid")
    end

    it "when a an email or password section is not filled out, the user is redirected
      back to the login page and an error noting invalid credentials is shown on the page" do
      visit login_path
      fill_in :email, with: "Fiona3@gmail.com"
      fill_in :password, with: ""
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Credentials Invalid")

      visit login_path
      fill_in :email, with: ""
      fill_in :password, with: "1234test"
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Credentials Invalid")
    end
  end
end 