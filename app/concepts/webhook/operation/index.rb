class Webhook
  class Index < Emilito::Operation::PresentCollection
    representer :render do
      include Representable::JSON::Collection
      items class: Webhook, decorator: Webhook::Representer::Show
    end
  end
end
