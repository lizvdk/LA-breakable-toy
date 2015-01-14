# encoding: utf-8

class ReportPhotoUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "http://lorempixel.com/g/500/500/city/"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  include CarrierWave::MiniMagick
  process :auto_orient
  process resize_to_limit: [500, 500]

  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  version :thumb do
    process resize_to_limit: [100, 100]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_limit: [75, 75]
  end
end
