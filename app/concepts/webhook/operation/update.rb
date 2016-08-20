class Webhook
  class Update < Webhook::Create
    model Webhook, :update

    contract Webhook::Contract::Create do
      property :workspace_id, writeable: false
    end
  end
end

