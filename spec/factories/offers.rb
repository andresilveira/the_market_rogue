FactoryGirl.define do
  factory :offer do
    item_name     'jellopy'
    slots         0
    refinement    0
    cards         ''
    price         1000
    vendor        'Le Vendor'
    shop_title    'Le Vendor Shop'
    map_location  'Prontera(123,321)'
  end
end
