class Webhook
  class Update < Webhook::Create
    model Webhook, :update
  end
end

