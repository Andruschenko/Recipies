class Recipe < ActiveRecord::Base
  belongs_to :chef
  # Validation
  validates :chef_id, presence: true
  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :summary, presence: true, length: { minimum: 10, maximum: 150 }
  validates :description, presence: true, length: { minimum: 20, maximum: 500 }

  # Mounts the given uploader on the given column. This means that assigning and reading from the column will upload and retrieve files.
  mount_uploader :picture, PictureUploader
  # server side picture validation
  validate :picture_size

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end