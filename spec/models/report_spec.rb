describe Report do
  let(:blank_values) { [nil, ""] }

  describe "#latitude" do
    it { should have_valid(:latitude).when(-90, 0, 90, 42.3603) }
    it do
      should_not have_valid(:latitude).when(-90.1, 90.1,
                                            *blank_values)
    end
  end

  describe "#longitude" do
    it { should have_valid(:longitude).when(-180, 0, 180, 71.0580) }
    it do
      should_not have_valid(:longitude).when(-180.1, 180.1,
                                             *blank_values)
    end
  end

  describe "#description" do
    it { should have_valid(:description).when("#{'x' * 500}", *blank_values) }
    it { should_not have_valid(:description).when("#{'x' * 501}") }
  end

  describe "#status" do
    it { should have_valid(:status).when("Open", "In Progress", "Closed") }
    it { should_not have_valid(:status).when("anything else", *blank_values) }
  end

  describe ".by_recency" do
    it "orders the posts by most recently updated first" do
      oldest = FactoryGirl.create(:report, updated_at: Time.now - 3.days)
      newest = FactoryGirl.create(:report, updated_at: Time.now - 1.day)
      middle = FactoryGirl.create(:report, updated_at: Time.now - 2.days)

      expect(Report.by_recency).to eq [newest, middle, oldest]
    end
  end

  describe ".geojson" do
    it "generates a geoJSON hash" do
      report = FactoryGirl.create(:report)
      expect(Report.geojson).to eq ({
        type: "FeatureCollection",
        features: [
          { type: "Feature",
            geometry: {
              type: "Point",
              coordinates: [report.longitude, report.latitude]
            },
            properties: {
              category: report.category.name,
              url: "/reports/#{report.id}",
              photo: report.photo.url,
              updated_at: report.display_date,
              id: "report-#{report.id}",
              icon: {
                html: report.category.icon,
                iconSize: [50, 50],
                iconAnchor: [25, 25],
                popupAnchor: [0, -25],
                className: "#{report.marker_color} map-icon"
              }
            }
          }
        ]
      })
    end
  end

  describe "#marker_color" do
    it "determines what color the report marker should be" do
      open_report = FactoryGirl.create(:report)
      in_progress_report = FactoryGirl.create(:report, status: "In Progress")
      closed_report = FactoryGirl.create(:report, status: "Closed")

      expect(open_report.marker_color).to eq "green"
      expect(in_progress_report.marker_color).to eq "yellow"
      expect(closed_report.marker_color).to eq "red"
    end
  end

  describe "#has_vote_from?" do
    it "returns true if given user has already voted on a report" do
      report = FactoryGirl.create(:report)
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:vote, user: user, report: report)

      expect(report).to have_vote_from user
    end

    it "returns false if given user has not already voted" do
      report = FactoryGirl.create(:report)
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:vote, report: report)

      expect(report).to_not have_vote_from user
    end
  end

  it { should belong_to(:user) }
  it { should belong_to(:category) }
end
