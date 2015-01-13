# encoding: utf-8

class ReportPhotoUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end
end
