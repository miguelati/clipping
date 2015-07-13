class Entity < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :shippings, dependent: :delete_all
	has_many :receivers, dependent: :delete_all
	has_many :categories, dependent: :delete_all
	
  attr_accessible :name, :avatar
	
	validates_presence_of :name, :on => :create
  
  mount_uploader :avatar, EntityAvatarUploader
end
