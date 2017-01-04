module PubSubService
  module SubscriberMixin
    def self.included(base)
      base.extend ClassMethods
      PubSubService::Observer.subscribe(base, with: :on_event)
    end

    module ClassMethods
      def on_event(event)
      end
    end
  end
end
