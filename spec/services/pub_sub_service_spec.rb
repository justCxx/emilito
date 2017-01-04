require 'rails_helper'

RSpec.describe PubSubService, type: :service do
  let(:publisher) do
    Class.new do
      include PubSubService::PublisherMixin
    end.new
  end

  describe 'subscriber' do
    subject!(:subscriber) do
      Class.new do
        include PubSubService::SubscriberMixin

        @recieved_events = []

        class << self
          attr_reader :recieved_events
          def on_event(event)
            @recieved_events << event
          end
        end
      end
    end

    context 'when publisher emit :example_event' do
      before { publisher.emit(:example_event) }
      it_is_asserted_by { subscriber.recieved_events == [:example_event] }
    end
  end
end
