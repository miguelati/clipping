class Shipping < ActiveRecord::Base
	has_and_belongs_to_many :receivers
	has_many :publications, dependent: :delete_all
	has_many :source_covers, dependent: :delete_all
	
	belongs_to :user
	belongs_to :entity
	
	accepts_nested_attributes_for :publications, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :source_covers, reject_if: :all_blank, allow_destroy: true
	
	attr_accessible :name, :entity_id, :publications_attributes, :source_covers_attributes, :individuals
	
	validates_presence_of :name
	validates_presence_of :entity_id
end
