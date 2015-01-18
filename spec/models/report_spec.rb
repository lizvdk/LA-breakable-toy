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


  it { should belong_to(:user) }
  it { should belong_to(:category) }
end
