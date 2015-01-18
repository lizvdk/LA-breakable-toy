require "rails_helper"

feature "admin updates status", %{
  As an admin
  I want to update a report's status
  So that I can commuicate the report's status with the site's users
  } do

    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let(:report) { FactoryGirl.create(:report) }

    scenario "admin may update status" do
      sign_in admin

      visit root_path
      click_on "Admin Dashboard"
      click_on "Reports"
    end
  end
