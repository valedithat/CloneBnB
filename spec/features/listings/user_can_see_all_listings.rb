require 'rails_helper'

describe "user can see all listings available" do
  scenario "when they visit the listings index page" do
    listing_1, listing_2 = Fabricate.times(2, :listing)
    image_1 = Fabricate(:image, listing: listing_1)
    image_2 = Fabricate(:image, listing: listing_2)
    visit listings_path

    expect(page).to have_content(listing_1.title)
    expect(page).to have_content(listing_2.title)
  end
end
