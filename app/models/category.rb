class Category < ActiveRecord::Base
  has_many :reports

  def icon
    case name
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
