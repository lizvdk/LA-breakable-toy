categories = ["General",
              "Damaged Sign",
              "City Trash Receptacle",
              "Litter",
              "Pick up Dead Animal",
              "Pothole",
              "Sidewalk Patch",
              "Streetlight",
              "Snow/Ice Control",
              "Unshoveled Sidewalk",
              "Other"]
categories.each do |category|
  Category.create(name: category)
end
