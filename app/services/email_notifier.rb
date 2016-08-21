class EmailNotifier
  def notify(offer)
    Alert.where(item_id: offer.item_id).each do |alert|
      if alert.should_fire_for_offer?(offer)
        AlertMailer.custom_email(offer.id).deliver_later
      end
    end
    offer
  end
end

