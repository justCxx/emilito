class WebhookDelivery
  module Representer
    class Show < Emilito::Representer::Base
      property :request, field: Hash do
        property :headers
        property :payload
      end

      property :request, field: Hash do
        property :status
        property :headers
        property :body
      end
    end
  end
end
