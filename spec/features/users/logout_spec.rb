require "rails_helper"

RSpec.describe "User can Log Out" do
  it "can log out" do 
    user = User.create!(name: "Alice", email: "alice@example.com", password: "hamburger1", password_confirmation: "hamburger1")

    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    #usually when you are doing a login type test, you need to do the entire login process which can get
    #repetative. The mock above (allow any instance of) allows you to avoid having to rebuild a page every time 
    #you run the test
    #this does not actually work when doing a logout function

    visit login_path
    fill_in :email, with: "alice@example.com"
    fill_in :password, with: "hamburger1"
    click_button "Login"

    visit root_path

    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Create An Account")

    click_on "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_content("Log In")
    expect(page).to have_content("Create A User")
  end
end