require 'rails_helper'

describe "a user can see trips" do
  it "with a role of traveler" do
    user = Fabricate(:user)
    user.roles.create!(title: "traveler")
    listing = Fabricate(:listing, title: "Super Cool Pad", cost_per_night: 30)
    Fabricate.times(3, :image, listing: listing)
    reservation = Reservation.create!(listing: listing,
                                      user: user,
                                      start_date: "01/01/2018",
                                      end_date: "04/01/2018")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    within(".sidebar") do
      click_on "Trips"
    end

    expect(current_path).to eq(user_trips_path(user))

    within(".my-trips .headers") do
      expect(page).to have_content("Check-In")
      expect(page).to have_content("Check-Out")
      expect(page).to have_content("Price")
      expect(page).to have_content("Status")
      expect(page).to have_content("Property")
      expect(page).to have_content("Address")
      expect(page).to have_content("Trip")
    end

    within(".my-trips .records") do
      expect(page).to have_link(listing.title)
      expect(page).to have_content("1/1/2018")
      expect(page).to have_content("1/4/2018")
      expect(page).to have_content("$90")
      expect(page).to have_content("pending")
      expect(page).to have_content(listing.street_address)
      expect(page).to have_link("##{reservation.id}")
    end

    click_on "Super Cool Pad"

    expect(current_path).to eq(listing_path(listing))
  end

  it "with the role of a host" do
    host = Fabricate(:user)
    #host = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    host.roles.create!(title: "host")
    listing = Fabricate(:listing, title: "Super Cool Pad", cost_per_night: 30)
    Fabricate.times(3, :image, listing: listing)
    reservation = Reservation.create!(listing: listing,
                                      user: host,
                                      start_date: "1/1/2018",
                                      end_date: "4/1/2018")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit dashboard_path

    within(".sidebar") do
      click_on "Trips"
    end

    expect(current_path).to eq(user_trips_path(host))

    within(".sidebar") do
      expect(page).to have_link("My Listings")
      expect(page).to have_link("Reservations")
      expect(page).to have_link("Messages")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Trips")
    end

    within(".my-trips .headers") do
      expect(page).to have_content("Check-In")
      expect(page).to have_content("Check-Out")
      expect(page).to have_content("Price")
      expect(page).to have_content("Status")
      expect(page).to have_content("Property")
      expect(page).to have_content("Address")
      expect(page).to have_content("Trip")
    end

    within(".my-trips .records") do
      expect(page).to have_link(listing.title)
      expect(page).to have_content("1/1/2018")
      expect(page).to have_content("1/4/2018")
      expect(page).to have_content("$90")
      expect(page).to have_content("pending")
      expect(page).to have_content(listing.street_address)
      expect(page).to have_link("##{reservation.id}")
    end

    click_on "Super Cool Pad"

    expect(current_path).to eq(listing_path(listing))
  end
end
