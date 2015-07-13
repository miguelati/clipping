class Publication < ActiveRecord::Base
	belongs_to :shipping
	belongs_to :category, counter_cache: true
	
	attr_accessible :source, :source_url, :title, :url, :category_id, :short_content, :published_at
	
	validates_presence_of :title, :on => :create
	
end
