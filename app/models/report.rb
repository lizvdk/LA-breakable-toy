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

  def self.by_recency
    order(created_at: :desc)
  end

  def simple_coordinates
    sprintf("%.4f, %.4f", latitude, longitude)
  end

  def image_alt
    "category.name-#{simple_coordinates}"
  end

  def marker_color
    case status
    when "Open"
      return "green"
    when "In Progress"
      return "yellow"
    when "Closed"
      return "red"
    else
      return "gray"
    end
  end

  def iconHTML
    case category.name
    when "General" || "Other"
      "&#57346;"
    when "Damaged Sign"
      "&#57357;"
    when "City Trash Receptacle"
      "&#57344;"
    when "Litter"
      "&#57344;"
    when "Pick up Dead Animal"
      "&#57355;"
    when "Pothole"
      "&#57350;"
    when "Sidewalk Patch"
      "&#57345;"
    when "Streetlight"
      "&#57357;"
    when "Snow/Ice Control"
      "&#57349;"
    when "Unshoveled Sidewalk"
      "&#57353;"
    else
      "&#57346;"
    end
  end

end
