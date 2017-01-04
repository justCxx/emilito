require 'rails_helper'

RSpec.describe WebhookService, type: :service do
  describe WebhookService::Monitor do
    describe '.on_event' do
      before { PubSubService::Observer.process_event(:update) }

      it_is_asserted_by { WebhookService::Worker.jobs.count == 1 }
    end
  end
end
