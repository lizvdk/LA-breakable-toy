require "rails_helper"

feature "admin updates status", %{
  As an admin
  I want to update a report's status
  So that I can commuicate the report's status with the site's users
  } do

    let(:admin) { FactoryGirl.create(:user, admin: true) }

    scenario "admin may update status" do
      FactoryGirl.create(:report)
      sign_in admin

      visit root_path
      click_on "Admin Dashboard"

      select "Closed", from: "report[status]"
      click_on "Update Report"
      expect(page).to have_select("report[status]", selected: "Closed")
    end
  end
