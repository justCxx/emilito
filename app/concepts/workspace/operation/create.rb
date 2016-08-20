class Workspace
  class Create < Trailblazer::Operation
    include Model
    model Workspace, :create

    contract Workspace::Contract::Create

    extend  Trailblazer::Operation::Representer::DSL
    include Trailblazer::Operation::Representer::Rendering
    include Trailblazer::Operation::Responder

    representer Workspace::Representer::Show

    def process(params)
      validate(params) do
        contract.save
      end
    end
  end
end
