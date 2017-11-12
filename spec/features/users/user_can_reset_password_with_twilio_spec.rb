require 'rails_helper'

describe "user tries to log in" do
  xit "they have forgotten password" do
    user =  Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.roles.create(title: "traveler")
    allow_any_instance_of(TwilioService).to receive(:send_password_code).and_return("1234")
    visit login_path

    click_on "Forgot Password?"
    expect(current_path).to eq(new_code_path)

    fill_in("code[phone_number]", with: '+15202621279')

    click_on "Send Message"

    expect(current_path).to eq(edit_code_path(Code.last))

    fill_in("code[body]", with: Code.last.body)
    click_on "Verify"

    expect(current_path).to eq(reset_password_path)

    fill_in("code[password]", with: "password")
    fill_in("code[password_confirmation]", with: "password")

    click_on "Reset Password"
    within(".success") do
      expect(page).to have_content("Password successfully changed")
    end

    expect(current_path).to eq(login_path)

    fill_in("session[email]", with: "email@email.com")
    fill_in("session[password]", with: "password")

    within(".login_btn") do
      click_on "Login"
    end

    within(".success") do
      expect(page).to have_content("Logged in as Castle Pines")
    end
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Welcome, Castle Pines")
  end
end
