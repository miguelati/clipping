class User < ActiveRecord::Base

	has_and_belongs_to_many :entities
	has_many :shippings, dependent: :nullify
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :is_admin, :entity_ids
  # attr_accessible :title, :body
	
	validates_presence_of :name, :on => :create
	validates_presence_of :email, :on => :create
	validates_uniqueness_of :name, :on => :create
	validates_uniqueness_of :email, :on => :create
	
	def mail_style
		"\"#{self.name}\" <#{email}>"
	end
	
	
end
