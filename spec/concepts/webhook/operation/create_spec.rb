require 'rails_helper'
require 'support/workspace_context'

describe Webhook::Create do
  describe '.run' do
    include_context 'workspace_context'

    let(:webhook_params) do
      attributes_for(:webhook).merge(workspace_id: workspace.id)
    end

    subject { described_class.run(webhook_params) }

    it 'create a new Webhook from params' do
      res, op = subject

      expect(res).to be, -> { op.contract.errors.messages }
      expect(op.model).to be_kind_of Webhook
      expect(op.model.persisted?).to be true
    end

    context 'when optional params not passed' do
      let(:webhook_params) do
        { name: 'web', url: Faker::Internet.url, workspace_id: workspace.id }
      end

      it 'create a new Webhook with defaults' do
        res, op = subject

        expect(res).to be, -> { op.contract.errors.messages }

        expect(op.model.name).to eq 'web'
        expect(op.model.events).to eq ['create']
        expect(op.model.active).to eq true
      end
    end
  end
end
