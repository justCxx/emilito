require 'rails_helper'
require 'support/shared_contexts/workspace_context'

RSpec.describe Webhook::Delivery do
  describe '.call' do
    include_context 'workspace context'

    subject(:res) { Webhook::Delivery.(params) }

    let(:errors)  { res['contract.default'].errors.messages }
    let(:params)  { { id: webhook.id, delivery: { event: 'create' } } }
    let(:webhook) { create(:webhook, workspace: workspace) }

    before { stub_request(:post, webhook.url).to_return(status: 200) }

    it 'returns the operation result' do
      is_asserted_by { res }
      is_asserted_by { res['model'] }
      is_asserted_by { res['contract.default.class'] }
      is_asserted_by { res['representer.render.class'] }
    end

    it do
      is_asserted_by { res['model'].is_a? WebhookDelivery }
      is_asserted_by { res['model'].persisted? }
    end

    it do
      expect(WebMock).to have_requested(:post, webhook.url)
        .with(headers: res['model'].request['headers'])
    end

    describe 'result' do
      let(:params) do
        {
          id: webhook.id,
          delivery: { request: { payload: { status: :ok } }, event: 'create' }
        }
      end

      let(:request)  { res['model'].request }
      let(:response) { res['model'].response }

      let(:request_response) do
        { status: 200,
          headers: { 'content-type' => 'application/json' },
          body: 'OK' }
      end

      before { stub_request(:post, webhook.url).to_return(request_response) }

      it 'delivery request should be have headers' do
        headers = request['headers']
        is_asserted_by { headers['User-Agent'] == 'Emilito-Hookshot' }
        is_asserted_by { headers['Content-Type'] == 'application/json' }
        is_asserted_by { headers['X-Emilito-Event'] == 'create' }
        is_asserted_by { headers['X-Emilito-Delivery'] == res['model'].id }
      end

      it 'delivery response should be persisted' do
        is_asserted_by { response['status'] == 200 }
        is_asserted_by { response['headers'] == request_response[:headers] }
        is_asserted_by { response['body'] == 'OK' }
      end

      context 'when a webhook has a :secret property' do
        let(:webhook_secret) { "The Eagle's Gift" }
        let(:webhook) { create(:webhook, secret: webhook_secret) }
        let(:headers) { res['model'].request['headers'] }

        let(:digest) do
          sha1_digest = OpenSSL::Digest.new('sha1')
          data = params.dig(:delivery, :request, :payload).to_json
          OpenSSL::HMAC.hexdigest(sha1_digest, webhook_secret, data)
        end

        it_is_asserted_by do
          headers['X-Emilito-Signature'] == "sha1=#{digest}"
        end
      end
    end
  end
end
