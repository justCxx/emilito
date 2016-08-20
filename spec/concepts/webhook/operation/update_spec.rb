require 'rails_helper'
require 'support/workspace_context'

describe Webhook::Update do
  describe '.run' do
    include_context 'workspace_context'

    let(:webhook) do
      params = attributes_for(:webhook).merge(workspace_id: workspace.id)
      Webhook::Create.(params).model
    end

    let(:webhook_params) do
      { id: webhook.id,
        name: 'a new webhook name',
        events: ['create', 'update'],
        url: Faker::Internet.url,
        ping_url: Faker::Internet.url,
        test_url: Faker::Internet.url,
        active: false }
    end

    subject { described_class.run(webhook_params) }

    it 'update a exists Webhook from params' do
      res, op = subject

      expect(res).to be, -> { op.contract.errors.messages }
      expect(op.model.persisted?).to be true

      expect(op.model.name).to eq webhook_params[:name]
      expect(op.model.events).to eq webhook_params[:events]
      expect(op.model.url).to eq webhook_params[:url]
      expect(op.model.ping_url).to eq webhook_params[:ping_url]
      expect(op.model.test_url).to eq webhook_params[:test_url]
      expect(op.model.active).to eq false
    end

    context 'when :workspace_id param is passed' do
      let(:new_workspace_id) { workspace.id + 1 }
      let(:webhook_params) { super().merge(workspace_id: new_workspace_id) }

      it 'no update it param' do
        res, op = subject
        expect(res).to be, -> { op.contract.errors.messages }
        expect(op.model.workspace_id).to_not eq new_workspace_id
        expect(op.model.workspace_id).to eq webhook.workspace_id
      end
    end
  end
end
