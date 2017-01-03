module Api
  module V3
    class TicketsController < Api::V3::ApplicationController
      before_action :wrap_relationship_params!

      def index
        endpoint Ticket::Index
      end

      def show
        endpoint Ticket::Show
      end

      def create
        endpoint Ticket::Create
      end

      def update
        endpoint Ticket::Update
      end

      def destroy
        endpoint Ticket::Delete
      end

      private

      def wrap_relationship_params!
        params[:ticket]&.merge!(params.slice(:workspace_id))
      end
    end
  end
end
