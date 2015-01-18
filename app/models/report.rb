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

  validates :status, presence: true
  validates :status, inclusion: { in: ["Open", "In Progress", "Closed"],
                                  message: "%{value} is not a valid status" }

  belongs_to :category
  belongs_to :user

  mount_uploader :photo, ReportPhotoUploader

  def image_alt
    sprintf("category.name-%.2dx%d", latitude, longitude)
  end
end
