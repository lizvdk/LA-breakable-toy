require "rails_helper"

describe User do
  let(:blank_values) { [nil, ""] }

  describe "#username" do
    it { should have_valid(:username).when("lizvdk", "liz123") }
    it { should_not have_valid(:username).when("xx", "#{'x' * 21 }", *blank_values) }
  end
end
