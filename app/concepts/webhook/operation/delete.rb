class Webhook
  class Delete < Emilito::Operation::Delete
    step Model(Webhook, :find_by)
    step :destroy!
  end
end
