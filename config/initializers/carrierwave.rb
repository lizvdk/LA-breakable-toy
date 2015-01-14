CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID_PROD"] || "",
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY_PROD"] || ""
  }
  config.fog_directory  = ENV["S3_BUCKET_PROD"]
  config.fog_public     = true
  config.fog_attributes = { "Cache-Control" => "max-age=#{ 365.day.to_i}" }
end
