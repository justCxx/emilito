require 'rails_helper'

RSpec.describe Webhook do
  describe '.subscribed' do
    subject(:subscribed) { Webhook.subscribed(events) }

    context 'when 2 Webhooks are subscribed to event :create' do
      let(:events) { [:create] }
      before { 2.times { Webhook.create(events: [:create]) } }
      it { expect(subscribed.count).to eq 2 }
    end
  end
end
