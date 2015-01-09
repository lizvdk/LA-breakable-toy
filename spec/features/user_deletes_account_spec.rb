require "rails_helper"

feature "delete account", %{
  As a user
  I want to delete my account
  So that I am no longer a user
} do

  let(:user) { FactoryGirl.create(:user) }

  scenario "user may delete their own account" do
    sign_in user

    visit edit_user_registration_path

    click_button "Cancel my account"

    expect(page).to have_content("Your account has been successfully
                                  cancelled")
  end
end
