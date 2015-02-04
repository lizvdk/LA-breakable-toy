require 'spec_helper'

feature "user unvotes", %q{
  As a User
  I want to delete my vote for a post
  So that I can undo my vote if it was an accident
} do

  let(:user) { FactoryGirl.create(:user) }
  let(:report) { FactoryGirl.create(:report) }

  scenario "user deletes vote" do
    FactoryGirl.create(:vote, user: user, report: report)
    sign_in user
    visit report_path(report)

    click_on "Remove Vote"

    expect(page).to have_content "0 Votes"
    expect(page).to have_content "Your vote has been removed"
  end

  scenario "user does not see button to un-vote if they have not voted" do
    visit report_path(report)
    expect(page).to_not have_content "Remove Vote"
  end
end
