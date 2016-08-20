class Webhook
  module Contract
    class Base < Reform::Form
      property :id
      property :name

      property :url
      property :ping_url
      property :test_url

      property :events
      property :active

      property :workspace_id
    end
  end
end
