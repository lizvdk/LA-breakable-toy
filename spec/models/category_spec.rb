describe Category do
  # let(:blank_values) { [nil, ""] }

  describe "#icon" do
    it "determines which symbol the report marker should display" do
      categories = FactoryGirl.create_list(:category, 10)

      categories[0].name = "Damaged Sign"
      categories[1].name = "City Trash Receptacle"
      categories[2].name = "Litter"
      categories[3].name = "Pick up Dead Animal"
      categories[4].name = "Pothole"
      categories[5].name = "Sidewalk Patch"
      categories[6].name = "Streetlight"
      categories[7].name = "Snow/Ice Control"
      categories[8].name = "Unshoveled Sidewalk"
      # categories[9].name = "Damaged Sign"


      expect(categories[0].icon).to eq "&#57357;"
      expect(categories[1].icon).to eq "&#57344;"
      expect(categories[2].icon).to eq "&#57344;"
      expect(categories[3].icon).to eq "&#57355;"
      expect(categories[4].icon).to eq "&#57350;"
      expect(categories[5].icon).to eq "&#57345;"
      expect(categories[6].icon).to eq "&#57357;"
      expect(categories[7].icon).to eq "&#57349;"
      expect(categories[8].icon).to eq "&#57353;"
      expect(categories[9].icon).to eq "&#57346;"

    end
  end
end
