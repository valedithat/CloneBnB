require "rails_helper"

describe "host can view reservations" do
  it "sees all reservations past, present, future" do
    traveler, host = Fabricate.times(2, :user)
    traveler.roles.create!(title: "traveler")
    host.roles.create!(title: "host")
    host.roles.create!(title: "traveler")
    listing = Fabricate(:listing, user: host)
    # r1, r2, r3, r4, r5, r6, r7 = Fabricate.times(7, :reservation, listing: listing, user: traveler)
    r1 = Fabricate(:reservation, listing: listing, user: traveler)
    # r1 = listing.reservations.create!(start_date: "1/3/2012",
    #                                     end_date: "1/4/2012",
    #                                     user_id: traveler.id,
    #                                     status: "pending",
    #                                     listing_id: listing.id)

    r2 = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "pending",
                                        listing_id: listing.id)

    r3 = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "confirmed",
                                          listing_id: listing.id)

    r4 = listing.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "confirmed",
                                         listing_id: listing.id)

    r5 = listing.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "cancelled",
                                         listing_id: listing.id)

    r6 = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "cancelled",
                                        listing_id: listing.id)

    r7 = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "complete",
                                          listing_id: listing.id)

    r8 = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "complete",
                                          listing_id: listing.id)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    visit dashboard_path
    click_on "Reservations"

    expect(page).to have_content("Reservations")
    expect(page).to have_content(r1.start_date)
    expect(page).to have_content(r2.start_date)
    expect(page).to have_content(r3.start_date)
    expect(page).to have_content(r4.start_date)
    expect(page).to have_content(r5.start_date)
    expect(page).to have_content(r6.start_date)
    expect(page).to have_content(r7.start_date)
    expect(page).to have_content(r8.start_date)
  end
end
