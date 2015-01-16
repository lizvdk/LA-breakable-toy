require "rails_helper"

feature "user edits account", %{
  As a user
  I want to edit account
  So that I can update my information
} do

  let(:user) { FactoryGirl.create(:user) }

  scenario "user may edit their own profile" do
    sign_in user

    visit root_path

    click_link user.email

    click_link "Edit Account"

    fill_in "Username", with: "changedusername1"
    fill_in "Current password", with: user.password
    click_button "Update"

    expect(page).to have_content "Your account has been updated successfully"
  end
end
