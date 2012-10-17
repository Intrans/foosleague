require 'factory_girl'

FactoryGirl.define do
  factory :player do
    sequence(:email) {|n|  "#{n}@adf.com" }
    name "name"
    sequence(:twitter_name) {|n| "twitter #{n}" }
  end
end