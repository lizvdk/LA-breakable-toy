require "rails_helper"

feature "user un-votes a report", %{
  As a User
  I want to delete my vote for a report
  So that I can undo my vote if it was an accident
} do
  scenario "user removes their votes" do
    vote = FactoryGirl.create(:vote)
    sign_in vote.user
    visit report_path(vote.report)

    click_on "Remove Vote"

    expect(page).to have_content "0 Votes"
    expect(page).to have_content "Your vote has been removed"
  end

  scenario "user does not see button to remove vote from post that they have not voted" do
    not_voted_report = FactoryGirl.create(:report)

    visit report_path(not_voted_report)
    expect(page).to_not have_content "Remove Vote"
  end
end
