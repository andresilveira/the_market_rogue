class Offer < ActiveRecord::Base

  validates :item_name, uniqueness: { scope: [
    :slots,
    :refinement,
    :cards,
    :price,
    :vendor,
    :shop_title,
    :map_location
  ]}

  def full_item_name
    refinement_string = refinement? ?  "+#{refinement}" : ""
    slots_string = slots? ? "[#{slots}]" : ""
    [refinement_string, item_name, slots_string].join(' ').strip
  end
end
