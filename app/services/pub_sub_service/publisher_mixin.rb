module PubSubService
  module PublisherMixin
    def self.included(base)
      base.send(:include, Wisper::Publisher)
      base.subscribe(PubSubService::Observer, with: :process_event)
    end

    def emit(event)
      broadcast(:event, event)
    end
  end
end
