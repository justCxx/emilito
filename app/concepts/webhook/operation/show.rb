class Webhook
  class Show < Trailblazer::Operation
    include Model
    model Webhook, :find

    extend  Trailblazer::Operation::Representer::DSL
    include Trailblazer::Operation::Representer::Rendering
    include Trailblazer::Operation::Responder

    representer Webhook::Representer::Show

    def process(*)
    end
  end
end
