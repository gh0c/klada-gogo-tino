class Team < ActiveRecord::Base
  mount_uploader :logo, PictureUploader
  
  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: true
  validates :link,  presence: true, uniqueness: true
  validates :short_name,  presence: true, uniqueness: true
  validates :conference,  presence: true
  
  validate  :logo_size
  validate  :conferences_east_west
  validates_inclusion_of :playoff, :in => [true, false]
  
  
  private

    
    # Validates the size of an uploaded picture.
    def logo_size
      if logo.size > 4.megabytes
        errors.add(:logo, "should be less than 4MB")
      end
    end
    
    def conferences_east_west
      if !(conference && (['east', 'west'].include? conference.downcase))
          errors.add(:conference, "should be either East or West")
      end
    end

      
end
