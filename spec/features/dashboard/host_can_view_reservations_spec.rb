require "rails_helper"

describe "host can view reservations" do
  it "sees all reservations past, present, future" do
    traveler = Fabricate(:user)
    traveler.roles.create!(title: "traveler")

    host = Fabricate(:user)
    host.roles.create!(title: "host")
    host.roles.create!(title: "traveler")
    listing = Fabricate(:listing, user: host)
    
    res_one = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "pending",
                                        listing_id: listing.id)

    res_two = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "pending",
                                        listing_id: listing.id)

    res_three = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "confirmed",
                                          listing_id: listing.id)

    res_four = listing.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "confirmed",
                                         listing_id: listing.id)

    res_five = listing.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "cancelled",
                                         listing_id: listing.id)

    res_six = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "cancelled",
                                        listing_id: listing.id)

    res_seven = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "complete",
                                          listing_id: listing.id)

    res_eight = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "complete",
                                          listing_id: listing.id)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    visit dashboard_path
    click_on "Reservations"

    expect(page).to have_content("Reservations")
    expect(page).to have_content(res_one.start_date)
    expect(page).to have_content(res_two.start_date)

    expect(page).to have_content(res_one.start_date)
    expect(page).to have_content(res_two.start_date)

    expect(page).to have_content(res_one.start_date)
    expect(page).to have_content(res_two.start_date)

    expect(page).to have_content(res_one.start_date)
    expect(page).to have_content(res_two.start_date)
  end
end
