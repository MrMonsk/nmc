class Work < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
  mount_uploader :work, WorkUploader
end
