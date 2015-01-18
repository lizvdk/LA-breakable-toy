require "rails_helper"

feature "user edits report", %{
  As a user
  I want to edit my report
  So that I can correct or update the information
  } do

  let(:report) { FactoryGirl.create(:report) }

  scenario "user may edit their own profile" do
    sign_in report.user
    visit report_path(report)
    click_link "Edit Report"

    fill_in "Description", with: "New description"
    click_button "Submit"

    expect(page).to have_content "Your report has been updated successfully"
    expect(page).to have_content "New description"
  end

  scenario "user may not edit another user's report" do
    visit report_path(report)
    expect(page).not_to have_content "Edit Review"
  end
end
