require 'rails_helper'

RSpec.describe 'Movie Details Page' do
  before(:each) do
    @user1 = User.create!(name: 'Chad', email: 'chad1@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user2 = User.create!(name: 'Jessica', email: 'jessica2@gmail.com', password: "1234test", password_confirmation: "1234test")
    @user3 = User.create!(name: 'Fiona', email: 'Fiona3@gmail.com', password: "1234test", password_confirmation: "1234test")
  end

  describe "a users access" do
    it 'has a button to create a viewing party that takes the user to (/users/:user_id/movies/:movie_id/viewing-party/new)' do
      visit login_path

      fill_in :email, with: "chad1@gmail.com"
      fill_in :password, with: "1234test"
      click_button "Login" 

      visit "/dashboard/movies/238"
      within('#create-new-viewing-party') do
        expect(page).to have_button('Create Viewing Party for The Godfather')
        click_button('Create Viewing Party for The Godfather')
        expect(current_path).to eq("/dashboard/movies/238/viewing_party/new")
      end
    end

    it 'has a button to return to the discover page' do
      visit  user_movie_path(@user1.id, 238)

      within '#discover-movies' do
        expect(page).to have_button('Discover Movies')
        click_on 'Discover Movies'

        expect(current_path).to eq("/users/#{@user1.id}/discover")
      end
    end

    it "has the following attributes of the movie: title, vote average, run time in hours/minutes,
      genres associated with the movie, summary description, first 10 cast members and the characters
      they play, total review count and each review's author and information" do
      visit user_movie_path(@user1.id, 238)

      within('#title') do
        expect(page).to have_content('The Godfather')
      end

      within('#vote-avg') do
        expect(page).to have_content('Vote Average: 8.7')
      end

      within('#summary') do
        expect(page).to have_content('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family.')
      end

      within('#runtime') do
        expect(page).to have_content('Runtime: 2hr 55min')
      end

      within('#genre') do
        expect(page).to have_content('Drama')
        expect(page).to have_content('Crime')
        expect(page).to_not have_content('Comedy')
      end

      within('#review-crastana') do
        expect(page).to have_content('Author: crastana')
        expect(page).to have_content('Review: The best movie ever')
      end

      within('#review-futuretv') do
        expect(page).to have_content('Author: futuretv')
        expect(page).to have_content('Review: The Godfather Review by Al Carlson')
      end

      within('#total-review-count') do
        expect(page).to have_content('2 Reviews')
      end

      within('#cast-members') do
        expect(page).to have_content('Marlon Brando as Don Vito Corleone')
        expect(page).to have_content('Al Pacino as Don Michael Corleone')
        expect(page).to_not have_content('Chris Pratt as Mario')
      end
    end
  end 

  describe "a visitors access" do
    it "if a visitor clicks the button to create a viewing party, they are redirected to the
      movie show page and see a message 'You must be logged in' " do

        visit "/dashboard/movies/#{238}"

        expect(page).to have_no_content("You must be logged in")
        click_button('Create Viewing Party for The Godfather')
        expect(current_path).to eq("/dashboard/movies/#{238}")
        expect(page).to have_content("You must be logged in")
        
      end
    end

  # it 'lists the first 10 cast members and the names of their characters' do
  #   visit user_discover_path(@user1.id)
  #   fill_in :keyword, with: 'Godfather'
  #   click_button('Search by Movie Title')

  #   within('#movie_238') do
  #     click_link('The Godfather')
  #   end

  #   within('#cast-members') do
  #     expect(page).to have_content('Marlon Brando as Don Vito Corleone')
  #     expect(page).to have_content('Al Pacino as Don Michael Corleone')
  #     expect(page).to_not have_content('Chris Pratt as Mario')
  #   end
  # end
  # end
end
