require 'rails_helper'

describe "user can see a listing" do
  scenario "when they visit the listing show page" do
    listing = Fabricate(:listing)
    image = Fabricate.times(3, :image, listing: listing)
    amenities = ["internet", "tv", "gym", "pool", "doorman"]

    amenities.each do |name|
      amenity = Amenity.create!(name: name)
      listing.listing_amenities.create!(amenity: amenity, value: true)
    end

    visit listings_path

    click_on "#{listing.title}"

    expect(current_path).to eq listing_path(listing)

    expect(page).to have_content(listing.title)
    expect(page).to have_content(listing.description)
    expect(page).to have_xpath("//img[@src='#{listing.images[0].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing.images[1].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing.images[2].image_url}']")

    within(".amenities") do
      expect(page).to have_content("Amenities at this property")
      expect(page).to have_content("Internet")
      expect(page).to have_content("Tv")
      expect(page).to have_content("Gym")
      expect(page).to have_content("Pool")
      expect(page).to have_content("Doorman")
    end
    end
end
