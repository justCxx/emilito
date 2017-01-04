FactoryGirl.define do
  factory :webhook do
    skip_create

    workspace

    name 'web'

    url { Faker::Internet.url }
    test_url { "#{url}/test" }
    ping_url { "#{url}/ping" }

    events { ['create'] }
    active true

    trait(:with_signature) do
      secret { Faker::Lorem.word }
    end

    initialize_with do
      Webhook::Create.(webhook: attributes, workspace_id: workspace.id)['model']
    end
  end
end
