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

  has_many :votes,
    dependent: :destroy,
    inverse_of: :report

  mount_uploader :photo, ReportPhotoUploader

  def self.by_recency
    order(updated_at: :desc)
  end

  def simple_coordinates
    sprintf("%.4f, %.4f", latitude, longitude)
  end

  def display_date
    updated_at.localtime.strftime("%m/%d/%Y at %I:%M%p")
  end

  def self.geojson
    geojson = Hash.new
    features = []
    geojson[:type] = "FeatureCollection"
    geojson[:features] = features
    by_recency.each do |report|
      features << {
        type: "Feature",
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
    end
    geojson
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

end
