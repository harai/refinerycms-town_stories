# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  def initialize(model = UUIDTools::UUID.random_create.to_s, mounted_as = nil)
    super(model, mounted_as)
  end

  include CarrierWave::RMagick

  storage :fog

  process resize_to_fit: [800, 800]
  
  version :m do
    process resize_to_fit: [480, 480]
  end
  
  version :s, from_version: :m do
    process resize_to_fill: [200, 200]
  end
  
  version :t, from_version: :s do
    process resize_to_fill: [100, 100]
  end

  version :t2, from_version: :t do
    process resize_to_fill: [50, 50]
  end

  def extension_white_list
    %w(jpg)
  end

  def filename
    "#{model}.jpg"
  end

  def self.url(id, type = nil)
    type_str = type ? type.to_s + '_' : ''
    "#{fog_host}/#{type_str}#{id}.jpg"
  end
end
