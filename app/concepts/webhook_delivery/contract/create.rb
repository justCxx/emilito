require 'disposable/twin/property/hash'

class WebhookDelivery
  module Contract
    class Create < Reform::Form
      feature Reform::Form::Dry
      include Disposable::Twin::Property::Hash

      property :id, default: -> { SecureRandom.uuid }

      property :webhook_id

      property :delivered, default: -> { false }
      property :event, virtual: true

      property :request, field: :hash do
        property :headers, default: -> { {} }
        property :payload, default: -> { {} }
      end

      property :response, field: :hash do
        property :status
        property :headers
        property :body
      end

      validation do
        required(:webhook_id).filled
        required(:delivered).filled(:bool?)
        required(:event).filled
        required(:request).schema do
          required(:headers).value(:hash?)
          required(:payload).value(:hash?)
        end
      end
    end
  end
end
