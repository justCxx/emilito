module WebhookService
  class Worker
    include Sidekiq::Worker

    def perform(event)
      webhooks = Webhook.subscribed(event)
      webhooks.each do |hook|
        Webhook::Delivery.(id: hook.id, delivery: { event: event })
      end
    end
  end
end
