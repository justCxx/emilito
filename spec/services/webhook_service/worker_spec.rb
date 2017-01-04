require 'rails_helper'
require 'support/shared_contexts/workspace_context'

RSpec.describe WebhookService::Worker do
  include_context 'workspace context'

  let(:webhook) { create(:webhook, workspace: workspace) }

  let(:worker) { WebhookService::Worker.new }

  describe '#perform' do
    before do
      stub_request(:post, webhook.url).to_return(status: 200)
      worker.perform(webhook.events[0])
    end

    it { expect(WebMock).to have_requested(:post, webhook.url) }
  end
end
