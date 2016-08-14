namespace :scheduled do
  desc 'Iterates over the items to be tracked, query it using the MarketRogue gem and save the result'
  task market_grabber: :environment do
    Rails.logger.info '[SCHEDULED] started at: ' + Time.now.to_s

    Item.tracked.each do |item|
      Rails.logger.info "[SCHEDULED] started item: #{item.name.to_s} - #{Time.now}"

      notifier = EmailNotifier.new
      OffersGrabber.new(item.name, :SellingOffer, notifier).offers if item.track_sellers
      OffersGrabber.new(item.name, :BuyingOffer, notifier).offers  if item.track_buyers

      Rails.logger.info "[SCHEDULED] finished item: #{item.name.to_s} - #{Time.now}"
    end

    Rails.logger.info '[SCHEDULED] finished at: ' + Time.now.to_s
  end
end
