class Report < ActiveRecord::Base
  validates :latitude, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90,
                                       less_than_or_equal_to: 90 }

  validates :longitude, presence: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180,
                                        less_than_or_equal_to: 180 }

  validates :description, length: { maximum: 500 }

  validates :category, presence: true
  validates :user, presence: true

  belongs_to :category
  belongs_to :user
end
