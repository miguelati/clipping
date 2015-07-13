class Category < ActiveRecord::Base
	has_many :publications
	has_many :source_cover
	belongs_to :entity
	
  attr_accessible :is_important, :name, :parent_id, :entity_id
	
	validates_presence_of :name, :on => :create
  validates_presence_of :entity_id, :on => :create
	validates_uniqueness_of :name, :scope => :entity_id, :on => :create
	
	scope :by_entity, lambda{ |entity_id| where("entity_id = ?", entity_id)}
	
end