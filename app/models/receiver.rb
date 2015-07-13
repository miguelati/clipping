class Receiver < ActiveRecord::Base
	has_and_belongs_to_many :shippings
	belongs_to :entity
	
	attr_accessible :email, :name, :entity_id
	
	validates_presence_of :name, :on => :create
	validates_presence_of :entity_id, :on => :create
	
	def mail_style
    if self.name.empty?
      self.email
    else
      "\"#{self.name}\" <#{self.email}>"
    end
	end
end
