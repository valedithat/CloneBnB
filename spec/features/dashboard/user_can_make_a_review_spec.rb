require "rails_helper"

describe "traveler can make a review" do
  it "for each listing a traveler has stayed at" do
    traveler, other_traveler, host = Fabricate.times(3, :user)
    traveler.roles.create!(title: "traveler")
    other_traveler.roles.create!(title: "traveler")
    host.roles.create!(title: "traveler")
    host.roles.create!(title: "host")

    a_listing, b_listing = Fabricate.times(2, :listing, user: host)
    #a_listing = host.listings.create!(street_address: "9001 Derp Road", description: "derp", city: "Denver", state: "CO", zipcode: "35343", max_occupancy: "2", title: "cool", list_category: "house", number_beds: "1", number_rooms: "1", cost_per_night: 234, number_baths: 1)
    #b_listing = host.listings.create!(street_address: "1212 Derp Lane", description: "derp", city: "Denver", state: "CO", zipcode: "35343", max_occupancy: "2", title: "cool", list_category: "house", number_beds: "1", number_rooms: "1", cost_per_night: 234, number_baths: 1)
    Fabricate.times(3, :image, listing: a_listing)
    Fabricate.times(3, :image, listing: b_listing)
    traveler.reservations.create!(start_date: "4/1/17", end_date: "4/2/17", listing_id: a_listing.id, status: "complete")
    other_traveler.reservations.create!(start_date: "4/1/17", end_date: "4/2/17", listing_id: b_listing.id, status: "complete")

    visit root_path
    click_on "Login"
    fill_in "session[email]", with: traveler.email
    fill_in "session[password]", with: traveler.password
    within(".login_btn") do
      click_on "Login"
    end
    click_on "Reviews"
    
    expect(page).to have_content(a_listing.street_address)

    within(".listing_#{a_listing.id}") do
      click_on "Leave a Review"
    end

    expect(current_path).to eq(listing_path(a_listing))
    expect(page).to have_link "Write a Review"  #

    click_on "Write a Review"

    expect(current_path).to eq(listing_reviews_new_path(a_listing))

    fill_in("review[title]", with: "This was great")
    fill_in("review[stars]", with: 5)
    fill_in("review[message]", with: "The house was beautiful, clean, and they had extra towels and bathroom amenities")
    click_on "Add Review"

    expect(current_path).to eq(listing_path(a_listing))
    expect(page).to have_content("This was great")
    expect(page).to have_content(5)
    expect(page).to have_content("The house was beautiful, clean, and they had extra towels and bathroom amenities")

    click_on "Logout"

    visit "/listings/#{a_listing.id}"
    expect(page).to_not have_link("Write a Review")
    expect(page).to have_content("Reviews")

    visit root_path
    click_on "Login"

    fill_in "session[email]", with: other_traveler.email
    fill_in "session[password]", with: other_traveler.password
    within(".login_btn") do
      click_on "Login"
    end

    visit "/listings/#{a_listing.id}"
    expect(page).to_not have_link("Write a Review")
    expect(page).to have_content("Reviews")
  end
end
