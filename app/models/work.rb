class Work < ActiveRecord::Base
  mount_uploader :work, WorkUploader
end
