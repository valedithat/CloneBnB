require 'rails_helper'

describe "user logs in" do
  it "as a traveler" do
    user = Fabricate(:user)
    user.roles.create(title: "traveler")
    visit root_path

    within(".navbar") do
      expect(page).to_not have_link("Become a Host")
    end

    click_on "Login"

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    within(".login_btn") do
      click_on "Login"
    end

    within(".navbar") do
      expect(page).to have_link("Become a Host")
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{user.first_name} #{user.last_name}")
    expect(page).to have_content(user.about_me)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.phone_number)
    expect(page).to have_link("Profile")
    expect(page).to have_link("Messages")
    expect(page).to have_link("Trips")

    expect(page).to_not have_link("Reservations")
    expect(page).to_not have_link("Listings")
  end

  it "as a host" do
    user = Fabricate(:user)
    user.roles.create!(title: "host")
    user.roles.create!(title: "traveler")
    visit root_path
    click_on "Login"

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    within(".login_btn") do
      click_on "Login"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{user.first_name} #{user.last_name}")
    expect(page).to have_content(user.about_me)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.phone_number)
    expect(page).to have_link("Profile")
    expect(page).to have_link("Messages")
    expect(page).to have_link("Trips")

    expect(page).to have_link("Reservations")
    expect(page).to have_link("Listings")
  end

  it "doesn't input email correctly" do
    user = Fabricate(:user)
    user.roles.create(title: "traveler")
    visit root_path
    click_on "Login"

    fill_in "session[email]", with: "Incorrect-Email"
    fill_in "session[password]", with: user.password
    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("Email or password has been entered incorrectly")
    expect(current_path).to eq(login_path)
  end

  it "doesn't input password correctly" do
    user = Fabricate(:user)
    user.roles.create(title: "traveler")
    visit root_path
    click_on "Login"


    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "NotDerp"
    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("Email or password has been entered incorrectly")
    expect(current_path).to eq(login_path)
  end

  it "with a status of inactive" do
    user = Fabricate(:user, email: "user@email.com", status: "inactive")
    user.roles.create(title: "traveler")

    visit root_path
    click_on "Login"

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password

    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")
  end
end
