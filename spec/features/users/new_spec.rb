require 'rails_helper'

RSpec.describe 'New Users Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Chad', email: 'chad1@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user2 = User.create!(name: 'Jessica', email: 'jessica2@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user3 = User.create!(name: 'Fiona', email: 'Fiona3@gmail.com', password: "1234test", password_confirmation: "1234test")
  end

  it 'should contain title of Viewing Party and a Home link that will redirect the user
    the landing page' do
    visit root_path
    within('#dashboard') do
      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
      click_link('Home')
      expect(current_path).to eq(root_path)
    end
  end

describe "user creation" do
  it "has a form to register a new user, that includes name, email (which is unique), password, password confirmation and a
    'Register' button" do
    visit new_user_path

    expect(page).to have_field(:name)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_field(:password_confirmation)
    expect(page).to have_button('Register')
  end

  it "a created used should have attributes: name, email, password_digest(encrypted password), and not have attributes of :password" do
    user = User.create!(name: "Meg", email: "meg@test.com", password: "password123", password_confirmation: "password123")

    expect(user).to_not have_attribute(:password)
    expect(user).to have_attribute(:password_digest)
    expect(user.password_digest).to_not eq("password123")
  end
end 

  describe "if the form is properly filled out" do
    it "once the form is properly filled out, the user will be taken to their dashboard page" do
      visit '/register'

      fill_in :name,	with: 'Max'
      fill_in :email,	with: 'WhatsForDinner@gmail.com'
      fill_in :password, with: "test1234"
      fill_in :password_confirmation, with: "test1234"
      click_button 'Register'

      expect(current_path).to eq("/dashboard")
    end
  end 

  describe "if the form is not completely filled out/filled out incorrectly" do
    it "if the name is not filled in, the user will be redirected back to the '/register' page and see an alert 
      that the name can't be blank" do
      visit '/register'

      expect(page).to have_no_content("Name can't be blank")

      fill_in :name,	with: ''
      fill_in :email,	with: 'pieisdelici0us@gmail.com'
      fill_in :password, with: "test1234"
      fill_in :password_confirmation, with: "test1234"
      click_button 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Name can't be blank")
    end

    it "if the email is not filled in, the user will be redirected back to the '/register' page and see an alert 
      that the name can't be blank" do
      visit '/register'

      expect(page).to have_no_content("Email can't be blank")

      fill_in :name,	with: 'Tammy'
      fill_in :email,	with: ''
      fill_in :password, with: "test1234"
      fill_in :password_confirmation, with: "test1234"
      click_button 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email can't be blank")
    end

    it "if the email is not unique, the user will be redirected to back to the '/register page and see
      an alert that the email they entered has already been taken" do
      visit '/register'

      expect(page).to have_no_content('Email has already been taken')

      fill_in :name,	with: 'Tammy'
      fill_in :email,	with: 'chad1@gmail.com'
      fill_in :password, with: "test1234"
      fill_in :password_confirmation, with: "test1234"
      click_button 'Register'

      expect(page).to have_content('Email has already been taken')
    end

    it "if the password is not filled out, the user will be redirected to back to the '/register page and see
      an alert that the password can't be blank" do
      visit '/register'

      expect(page).to have_no_content("Password can't be blank")

      fill_in :name,	with: 'Tammy'
      fill_in :email,	with: 'chicken@gmail.com'
      fill_in :password, with: ""
      fill_in :password_confirmation, with: "test1234"
      click_button 'Register'

      expect(page).to have_content("Password can't be blank")
    end

    it "if the password_confirmation is not filled out, the user will be redirected to back to the '/register page and see
      an alert that the email they entered has already been taken" do
      visit '/register'

      expect(page).to have_no_content("Password confirmation can't be blank")

      fill_in :name,	with: 'Tammy'
      fill_in :email,	with: 'chicken@gmail.com'
      fill_in :password, with: "test1234"
      fill_in :password_confirmation, with: ""
      click_button 'Register'

      expect(page).to have_content("Password confirmation can't be blank")
    end

    it "if the password and password_confirmation do not match, the user will be redirected to back to the '/register page and see
      an alert that the password and password confirmation do not match" do
      visit '/register'

      expect(page).to have_no_content("Password confirmation doesn't match Password")

      fill_in :name,	with: 'Tammy'
      fill_in :email,	with: 'chicken@gmail.com'
      fill_in :password, with: "test1234"
      fill_in :password_confirmation, with: "nottest1234"
      click_button 'Register'

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end 
end
