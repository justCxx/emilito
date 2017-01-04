require 'rails_helper'
require 'support/shared_contexts/workspace_context'

RSpec.describe Webhook::Update do
  describe '.call' do
    include_context 'workspace context'

    let(:webhook) do
      Webhook::Create.(
        webhook: attributes_for(:webhook), workspace_id: workspace.id
      )['model']
    end

    subject(:result) do
      Webhook::Update.(id: webhook.id, webhook: webhook_params)
    end

    context 'when params is valid' do
      let(:webhook_params) do
        { name: 'a new webhook name',
          events: ['create', 'update'],
          url: Faker::Internet.url,
          ping_url: Faker::Internet.url,
          test_url: Faker::Internet.url,
          active: false }
      end

      it 'update a exists Webhook from params' do
        is_asserted_by { result.success? }
        is_asserted_by { result['model'].persisted? }

        model = result['model']

        is_asserted_by { model.url  == webhook_params[:url] }
        is_asserted_by { model.name == webhook_params[:name] }

        is_asserted_by { model.events == webhook_params[:events] }
        is_asserted_by { model.active == false }

        is_asserted_by { model.ping_url == webhook_params[:ping_url] }
        is_asserted_by { model.test_url == webhook_params[:test_url] }
      end
    end

    describe 'update subscribed events' do
      subject(:events) { result['model'].events }

      context 'when :add_events param is passed' do
        let(:webhook_params) do
          { id: webhook.id, add_events: ['update'] }
        end

        it 'add passed events to exists events' do
          is_asserted_by { events == ['create', 'update'] }
        end
      end

      context 'when :remove_events param is passed' do
        let(:webhook_params) do
          { id: webhook.id, remove_events: ['create'] }
        end

        it 'takes passed events from exists events' do
          is_asserted_by { events == [] }
        end
      end

      context 'when :add_events and :remove_events params is passed' do
        let(:webhook_params) do
          { id: webhook.id,
            add_events: ['update', 'delete'],
            remove_events: ['create', 'update'] }
        end

        it 'first add and then takes passed events' do
          is_asserted_by { events == ['delete'] }
        end
      end

      context 'when :events, :add_events and :remove_events params is passed' do
        let(:webhook_params) do
          { id: webhook.id,
            events: ['create', 'liked'],
            add_events: ['update', 'delete'],
            remove_events: ['create', 'update'] }
        end

        it 'set :events then add :add_events and then take :remove_events' do
          is_asserted_by { events == ['liked', 'delete'] }
        end
      end
    end
  end
end
