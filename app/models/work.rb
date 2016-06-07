class Work < ActiveRecord::Base
  belongs_to :user
  mount_uploader :work, WorkUploader
end
