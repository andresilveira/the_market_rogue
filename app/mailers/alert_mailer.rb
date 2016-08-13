class AlertMailer < ApplicationMailer
  default from: 'andresilveira@gmail.com'

  def custom_email(offer_id)
    @offer = Offer.find(offer_id)
    mail(to: 'andresilveirah@gmail.com', subject: 'The Market Rogue Alert')
  end
end
