class Item < ApplicationRecord
  has_many :offers, dependent: :destroy

  # TODO: add the market to uniqueness scope
  validates :name, uniqueness: true

  scope :tracked, -> { where(track_sellers: true).or(Item.where(track_buyers: true)) }
end
