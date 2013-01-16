require 'carrierwave'
require 'uuidtools'

CarrierWave.configure do |config|
  conf_path = "#{Rails.root}/config/s3.yml"
  s3 = if File.exists?(conf_path)
    conf = YAML.load_file(conf_path)
    {
      key: conf[Rails.env]['access_key_id'],
      secret: conf[Rails.env]['secret_access_key'],
      bucket: conf[Rails.env]['bucket']
    }
  else
    { key: ENV['S3_KEY'], secret: ENV['S3_SECRET'], bucket: ENV['S3_BUCKET'] }
  end
  s3_region = 'ap-northeast-1'

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: s3[:key],
    aws_secret_access_key: s3[:secret],
    region: s3_region
  }
  config.fog_directory = s3[:bucket]
  host = "http://s3-#{s3_region}.amazonaws.com/#{s3[:bucket]}"
  config.asset_host = host
  # config.fog_endpoint = host
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.store_dir = nil
end
