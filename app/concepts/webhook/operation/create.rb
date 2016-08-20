class Webhook
  class Create < Trailblazer::Operation
    include Model
    model Webhook, :create

    contract Webhook::Contract::Create

    extend  Trailblazer::Operation::Representer::DSL
    include Trailblazer::Operation::Representer::Rendering
    include Trailblazer::Operation::Responder

    representer Webhook::Representer::Show

    def process(params)
      validate(params) do
        contract.save
      end
    end
  end
end
