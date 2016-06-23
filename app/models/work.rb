class Work < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
