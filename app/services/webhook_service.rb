module WebhookService
  class Monitor
    include PubSubService::SubscriberMixin

    def self.on_event(event)
      WebhookService::Worker.perform_async(event)
    end
  end
end
