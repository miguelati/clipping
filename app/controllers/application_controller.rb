# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
	
	private
	
	def user_authorization
		redirect_to(root_url) unless current_user.is_admin?
	end
	
	def method_name
		
	end
end
