class Alert < ApplicationRecord
  OPERATIONS = { 
    greater_than_or_equal_to: '>=',
    less_than_or_equal_to: '<='
  }

  belongs_to :item
end
