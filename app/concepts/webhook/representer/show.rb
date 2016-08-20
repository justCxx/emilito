require 'representable/json'

class Webhook
  module Representer
    class Show < Representable::Decorator
      include Representable::Hash
      include Representable::Hash::AllowSymbols
      include Representable::JSON

      property :id
      property :name
      property :url
      property :ping_url
      property :test_url
      property :events
      property :active
      property :created_at
      property :updated_at
    end
  end
end
