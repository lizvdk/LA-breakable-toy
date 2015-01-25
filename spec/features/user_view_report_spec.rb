require "rails_helper"

feature "user view a report", %{
  As an user
  I want view a report
  So I can see its details
  } do

    let(:report) { FactoryGirl.create(:report) }

    scenario "report displays" do
      visit report_path(report)
      expect(page).to have_content(report.category.name)
      expect(page).to have_content(report.status)
      expect(page).to have_content(report.simple_coordinates)
      expect(page).to have_content(report.user.username)
    end
  end
