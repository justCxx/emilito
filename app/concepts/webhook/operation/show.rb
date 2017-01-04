class Webhook
  class Show < Emilito::Operation::Present
    step Model(Webhook, :find_by)
    representer :render, Webhook::Representer::Show
  end
end
