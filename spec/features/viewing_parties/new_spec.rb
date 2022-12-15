require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
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

  it 'should have the name of the movie title above a form' do
    visit new_user_movie_viewing_party_path(@user1.id, 238)

    expect(page).to have_content('The Godfather')
  end

  it "should have a form with the following fields: party_duration, date, start_time, check boxes
    next to each user in the system, a button to create party and details about the movie" do
    visit new_user_movie_viewing_party_path(@user1.id, 238)

    expect(page).to have_field(:duration)
    expect(page).to have_field(:date)
    expect(page).to have_field(:start_time)
    expect(page).to have_button('Create Party')
  end

  it "the party_duration field should be pre-filled out with default value of movie run time in
    minutes" do
    visit new_user_movie_viewing_party_path(@user1.id, 238)

    expect(page).to have_field(:duration, with: 175)
    # will want to make a method to change hours minutes to minutes
  end

  xit "if a party is successfully created, the user should be redirected back to their dashboard
    where they will see a list of parties they are hosting and a list of parties they are
    invited to " do
    visit new_user_movie_viewing_party_path(@user1.id, 238)

    fill_in :duration, with: 175
    fill_in :date, with: '2022/12/01'
    fill_in :start_time, with: '11:00'
    click_button 'Create Party'

    expect(current_path).to eq("/dashboard")

    within("#viewing-parties-hosting") do
      expect(page).to have_content('The Godfather')
    end 
  end

  it 'should not create a viewing party if the time is not entered' do
    visit new_user_movie_viewing_party_path(@user1.id, 238)

    fill_in :duration, with: 175
    fill_in 'date', with: '2022/12/01'
    fill_in 'start_time', with: ''
    click_button 'Create Party'

    expect(current_path).to eq(new_user_movie_viewing_party_path(@user1.id, 238))
    expect(page).to have_content("Start time can't be blank")
  end

  it 'should not create a viewing party if the dates not filled out' do
    visit new_user_movie_viewing_party_path(@user1.id, 238)

    fill_in :duration, with: 175
    fill_in 'date', with: ''
    fill_in 'start_time', with: '19:00'
    click_button 'Create Party'

    expect(current_path).to eq(new_user_movie_viewing_party_path(@user1.id, 238))
    expect(page).to have_content("Date can't be blank")
  end
end
