require 'rails_helper'

describe "as a logged in admin" do
  it "they can remove a listing from the admin listings index" do
    host = Fabricate(:user)
    host.roles.create(title: "host")
    listing_one, listing_two, listing_three = Fabricate.times(3, :listing, user: host)
    Fabricate.times(3, :image, listing: listing_one)
    Fabricate.times(3, :image, listing: listing_two)
    Fabricate.times(3, :image, listing: listing_three)
    admin = Fabricate(:user)
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_on "Listings"

    expect(current_path).to eq(admin_listings_path)

    within(".listing-#{listing_one.id}") do
      click_button("Delete")
    end

    expect(page).to_not have_content(listing_one.title)
  end

  it "they can remove a listing from the admin listing show page" do
    host = Fabricate(:user)
    host.roles.create(title: "host")
    listing = Fabricate(:listing, user: host, title: "Big House")
    Fabricate.times(3, :image, listing: listing)

    admin = Fabricate(:user)
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_listing_path(listing)
    within(".admin") do
      click_button("Delete")
    end
    expect(current_path).to eq(admin_listings_path)
    expect(page).to_not have_content("Big House")
  end

  it "they can remove a review from the admin reviews index" do
    host, traveler, admin  = Fabricate.times(3, :user)
    host.roles.create(title: "host")
    traveler.roles.create(title: "traveler")
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    listing_one, listing_two, listing_three = Fabricate.times(3, :listing, user: host)
    review_one = listing_one.reviews.create!(title: "Mediocre night",
                                stars: 3,
                                message: "the pillows were stinky")
    review_two = listing_two.reviews.create!(title: "Fabulous night",
                                stars: 4,
                                message: "chipotle next door so I ate my feelings")
    review_three = listing_three.reviews.create!(title: "worst night ever",
                                  stars: 1,
                                  message: "the owner wanted to talk about her feelings all night. no go")

    visit admin_dashboard_path
    click_on "Reviews"

    expect(current_path).to eq(admin_reviews_path)

    within(".review-#{review_one.id}") do
      expect(page).to have_content("Mediocre night")
      expect(page).to have_content("3")
      expect(page).to have_content("the pillows were stinky")
      click_on "Delete"
    end

    expect(current_path).to eq(admin_reviews_path)
    expect(page).to_not have_content("Mediocre night")
    expect(page).to_not have_content("★ 3 ★")
    expect(page).to_not have_content("the pillows were stinky")
  end
end
