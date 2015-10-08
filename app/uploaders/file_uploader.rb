class FileUploader < CarrierWave::Uploader::Base
  storage :dropbox
end
