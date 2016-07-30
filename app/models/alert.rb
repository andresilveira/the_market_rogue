class Alert < ApplicationRecord
  OPERATIONS = %w(>= <=)

  belongs_to :item
end
