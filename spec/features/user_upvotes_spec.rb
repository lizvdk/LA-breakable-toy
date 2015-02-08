require "rails_helper"

feature "user upvotes a report", %{
  As a user
  I want to upvote a report
  So that I can express my concern about the report
} do
  let(:report) { FactoryGirl.create(:report) }

  context "as an authenticated user" do
    before(:each) do
      user = FactoryGirl.create(:user)
      sign_in user
      visit report_path(report)
      click_button "Fix it!"
    end

    scenario "user upvotes a report" do
      expect(page).to have_content "1 Vote"
      expect(page).to have_content "Your concern has been recorded!"
    end

    scenario "user cannot upvote a report more than once" do
      expect(page).to_not have_button "Fix it!"
    end
  end

  scenario "unauthenticated user cannot vote on a report" do
    visit report_path(report)
    expect(page).to_not have_button "Fix it!"
  end
end
