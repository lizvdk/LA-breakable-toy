require "rails_helper"

feature "view all reports" do

  scenario "good" do
    visit root_path
    click_on "View Reports"
  end
end
