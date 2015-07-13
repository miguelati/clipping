class SenderWorker
  include Sidekiq::Worker
  
  def perform(shipping, mail)
    ReceiverMailer.clipping_email(shipping, mail)
  end
end