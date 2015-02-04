class Vote < ActiveRecord::Base
  belongs_to :user,
             inverse_of: :votes

  belongs_to :report,
             inverse_of: :votes

  validates :user, presence: true
  validates :report, presence: true
  validates :report_id, uniqueness: { scope: :user_id }
end
