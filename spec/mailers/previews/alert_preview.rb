# Preview all emails at http://localhost:3000/rails/mailers/alert
class AlertPreview < ActionMailer::Preview
  def custom_email_preview
    AlertMailer.custom_email(Offer.last)
  end
end
