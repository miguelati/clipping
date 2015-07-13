class SourceCover < ActiveRecord::Base
	belongs_to :source
	belongs_to :shipping
	
	
  attr_accessible :image_cover, :shipping_id, :source_id, :name
	
	
	mount_uploader :image_cover, SourceCoverUploader
end
