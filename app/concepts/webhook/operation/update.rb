class Webhook
  class Update < Webhook::Create
    model Webhook, :update

    contract Webhook::Contract::Create do
      property :workspace_id, writeable: false

      property :add_events, virtual: true, setter: -> (represented:, fragment:, **) {
        represented.events += fragment
      }

      property :remove_events, virtual: true, setter: -> (represented:, fragment:, **) {
        represented.events -= fragment
      }

      validation do
        optional(:add_events).each(:str?)
        optional(:remove_events).each(:str?)
      end
    end
  end
end

