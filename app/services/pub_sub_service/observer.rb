module PubSubService
  class Observer
    class << self
      include Wisper::Publisher

      def process_event(event)
        broadcast(:event, event)
      end
    end
  end
end
