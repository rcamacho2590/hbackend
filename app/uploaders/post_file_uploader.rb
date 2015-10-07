class PostFileUploader < CarrierWave::Uploader::Base
  storage :dropbox
end
