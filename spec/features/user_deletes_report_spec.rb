require "rails_helper"

feature "user deletes report", %{
  As a user
  I want to delete my report
  So I can remove it from the site.
  } do

  let(:report) { FactoryGirl.create(:report) }

  scenario "user may delete their own report" do
    sign_in report.user
    visit report_path(report)
    click_link "Delete Report"

    expect(page).to have_content "Report deleted"
  end

  scenario "user may not delete another user's report" do
    visit report_path(report)
    expect(page).not_to have_content "Delete Report"
  end
end
