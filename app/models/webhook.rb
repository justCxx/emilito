class Webhook < ApplicationRecord
  belongs_to :workspace

  has_many :webhook_deliveries
  has_many :deliveries, class_name: WebhookDelivery

  scope :subscribed, ->(events) do
    where('events @> ARRAY[?]::varchar[]', events)
  end
end
