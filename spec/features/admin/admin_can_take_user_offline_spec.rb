describe "as a logged in admin" do
  it "they can remove a user's content" do
    host, admin = Fabricate.times(2, :user)
    host.roles.create(title: "host")
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    listing_one, listing_two, listing_three = Fabricate.times(3, :listing, user: host)
    Fabricate.times(3, :image, listing: listing_one)
    Fabricate.times(3, :image, listing: listing_two)
    Fabricate.times(3, :image, listing: listing_three)

    visit listings_path

    expect(page).to have_link(listing_one.title)
    expect(page).to have_link(listing_two.title)
    expect(page).to have_link(listing_three.title)

    visit admin_dashboard_path
    within(".sidebar") do
      click_on "Users"
    end

    expect(page).to have_content("active")
    expect(current_path).to eq(admin_users_path)

    click_on "Deactivate User"

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content("inactive")

    visit listings_path

    expect(page).to_not have_link(listing_one.title)
    expect(page).to_not have_link(listing_two.title)
    expect(page).to_not have_link(listing_three.title)

    visit listing_path(listing_one)

    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")
    expect(host.listings.count).to eq(3)
    expect(host.listings.first.title).to eq(listing_one.title)
  end
end
