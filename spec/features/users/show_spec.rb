require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  before(:each) do
    @user1 = User.create!(name: 'Chad', email: 'chad1@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user2 = User.create!(name: 'Jessica', email: 'jessica2@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user3 = User.create!(name: 'Fiona', email: 'Fiona3@gmail.com', password: "1234test", password_confirmation: "1234test")
  end

  it 'should display users name at the top of the page if the user has logged in' do
    visit login_path

        fill_in :email, with: "chad1@gmail.com"
        fill_in :password, with: "1234test"
        click_button "Login"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Welcome #{@user1.name}")
      expect(page).to_not have_content("#{@user2.name}'s Dashboard")
  end

  it 'should have a button to discover movies that redirects to the user discover page' do
    visit login_path

    fill_in :email, with: "chad1@gmail.com"
    fill_in :password, with: "1234test"
    click_button "Login"

    expect(current_path).to eq("/dashboard")

    within '#discover-movies' do
      expect(page).to have_button('Discover Movies')
      click_on 'Discover Movies'
      expect(current_path).to eq("/users/#{@user1.id}/discover")
    end
  end

  it 'should contain title of Viewing Party and a Home link that will redirect to the user landing page' do
    visit login_path

    fill_in :email, with: "chad1@gmail.com"
    fill_in :password, with: "1234test"
    click_button "Login"

    expect(current_path).to eq("/dashboard")
    within('#dashboard') do
      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
      click_link('Home')
      expect(current_path).to eq(root_path)
    end
  end

  describe 'Viewing Parties' do
    it 'should have a section that lists viewing parties' do
      visit login_path

      fill_in :email, with: "chad1@gmail.com"
      fill_in :password, with: "1234test"
      click_button "Login"

      expect(current_path).to eq("/dashboard")

      within("#viewing-parties-hosting") do
        expect(page).to have_content('Viewing Parties - Hosting')
      end
    end

    it 'should show viewing parties that the user has been invited to' do
      visit login_path

      fill_in :email, with: "chad1@gmail.com"
      fill_in :password, with: "1234test"
      click_button "Login"

      expect(current_path).to eq("/dashboard")

      within '#viewing-parties-attending' do
        expect(page).to have_content('Viewing Parties - Attending')
      end
    end
    # [ ] Movie Image
    # [ ] Movie Title, which links to the movie show page
    # [ ] Date and Time of Event
    # [ ] Who is hosting the event
    # [ ] List of users invited, with my name in bold

    # I should also see the viewing parties that the user has created with the following details:

    # [ ] Movie Image
    # [ ] Movie Title, which links to the movie show page
    # [ ] Date and Time of Event
    # [ ] That I am the host of the party
    # [ ] List of friends invited to the viewing party
  end
end
