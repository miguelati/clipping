class ReceiverMailer < ActionMailer::Base
  
  default from: "\"Clipping Social Cherry\" <clipping@socialcherry.com.py>"
	
	def clipping_email(shipping, receiver)
		@shipping = shipping
		mail(bcc: receiver, subject: "Noticias de la fecha #{"%02d" % Time.now.day}/#{"%02d" % Time.now.month}/#{Time.now.year.to_s}")
	end
end
