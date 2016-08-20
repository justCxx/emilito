module Api
  module V3
    class WebhooksController < Api::V3::ApplicationController
      def index
        respond Webhook::Index
      end

      def show
        respond Webhook::Show
      end

      def create
        respond Webhook::Create, namespace: [:api, :v3, workspace]
      end

      def update
        respond Webhook::Update, namespace: [:api, :v3, workspace]
      end

      def destroy
        respond Webhook::Delete, namespace: [:api, :v3, workspace]
      end

      protected

      def workspace
        @workspace ||= Workspace.find(params[:workspace_id])
      end
    end
  end
end
