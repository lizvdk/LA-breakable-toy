require "rails_helper"

RSpec.configure do |config|
  config.before(:example) do
    FactoryGirl.create(:vote)
  end
end

describe Vote do

  it { should belong_to :user }
  it { should belong_to :report }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:report).when(Report.new) }
  it { should_not have_valid(:report).when(nil) }

  it { should validate_uniqueness_of(:report_id).scoped_to(:user_id) }
end
