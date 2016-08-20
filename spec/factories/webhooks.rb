FactoryGirl.define do
  factory :webhook do
    workspace

    name 'web'

    url { Faker::Internet.url }
    test_url { "#{url}/test"}
    ping_url { "#{url}/ping" }

    events { ['create'] }
    active true
  end
end
