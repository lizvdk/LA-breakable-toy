require "rails_helper"

feature "user submits a report", %{
  As a user
  I want to report an issue
  So I can notify city hall and other users of the issue
} do

  scenario "valid input" do
    report = FactoryGirl.build(:report)
    sign_in(report.user)

    visit root_path

    click_on "Report an Issue"

    select report.category.name, from: "Category"
    fill_in "Latitude", with: report.latitude
    fill_in "Longitude", with: report.longitude
    click_on "Submit Report"

    expect(page).to have_content "Report Submitted"
    expect(page).to have_content report.category.name
    expect(page).to have_content report.latitude
    expect(page).to have_content report.longitude
  end

  scenario "invalid input" do
    report = FactoryGirl.build(:report)
    sign_in(report.user)

    visit root_path

    click_on "Report an Issue"

    click_on "Submit Report"

    expect(page).to have_content "can't be blank"
  end

  scenario "unregistered user cannot submit a report" do
    visit root_path

    click_on "Report an Issue"

    expect(page).to have_content "You must sign in"
  end
end
