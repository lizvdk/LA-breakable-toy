require "rails_helper"

feature "user signs out", %{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten on the machine I"m using
} do

  let(:user) { FactoryGirl.create(:user) }

  scenario "authenticated user signs out" do
    sign_in(user)

    visit root_path

    click_link "Sign Out"
    expect(page).to have_content("Signed out successfully")
  end

  scenario "unauthenticated user attempts to sign out" do
    visit "/"
    expect(page).to_not have_content("Sign Out")
  end
end
