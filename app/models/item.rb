class Item < ApplicationRecord
  has_many :offers, dependent: :destroy

  # TODO: add the market to uniqueness scope
  validates :name, uniqueness: true

  scope :track_sellers, -> { where(track_sellers: true) }
end
