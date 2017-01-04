require 'rails_helper'
require 'support/shared_contexts/workspace_context'

RSpec.describe Webhook::Create do
  describe '.call' do
    include_context 'workspace context'

    let(:params) { {} }

    subject(:result) { Webhook::Create.(params) }

    it 'returns the operation result' do
      is_asserted_by { result }
      is_asserted_by { result['model'] }
      is_asserted_by { result['contract.default.class'] }
      is_asserted_by { result['representer.render.class'] }
    end

    context 'when params is valid' do
      let(:params) do
        { webhook: attributes_for(:webhook),
          workspace_id: workspace.id }
      end

      it do
        is_asserted_by { result.success? }
        is_asserted_by { result['model'].persisted? }
      end
    end

    context 'when optional params not passed' do
      let(:params) do
        { webhook: { name: 'web', url: Faker::Internet.url },
          workspace_id: workspace.id }
      end

      it 'create a new Webhook with default options' do
        is_asserted_by { result['model'].name == 'web' }
        is_asserted_by { result['model'].events == ['create'] }
        is_asserted_by { result['model'].active == true }
      end
    end
  end
end
