require "rails_helper"

feature "user submits a report", %{
  As a user
  I want to report an issue
  So I can notify city hall and other users of the issue
} do

  scenario "valid input" do
    report = FactoryGirl.build(:report)
    sign_in(report.user)
    photo = "spec/fixtures/images/test_photo.jpeg"

    visit root_path

    click_on "Report an Issue"

    select report.category.name, from: "Category"
    fill_in "Latitude", with: report.latitude
    fill_in "Longitude", with: report.longitude
    attach_file("Photo", photo)
    click_on "Submit"

    expect(page).to have_content "Report Submitted"
    expect(page).to have_content report.category.name
    expect(page).to have_content report.latitude
    expect(page).to have_content report.longitude
    expect(page).to have_selector("img[alt=\"#{report.image_alt}\"]")
  end

  scenario "invalid input" do
    report = FactoryGirl.build(:report)
    sign_in(report.user)

    visit root_path

    click_on "Report an Issue"

    click_on "Submit"

    expect(page).to have_content "can't be blank"
  end

  scenario "unregistered user cannot submit a report" do
    visit root_path

    click_on "Report an Issue"

    expect(page).to have_content "You need to sign in or sign up
                                  before continuing"
  end
end
