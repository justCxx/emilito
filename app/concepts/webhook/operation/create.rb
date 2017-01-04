class Webhook
  class Create < Emilito::Operation::Create
    contract Webhook::Contract::Base do
      feature Reform::Form::Dry

      property :events, default: -> { ['create'] }
      property :active, default: -> { true }

      validation do
        required(:workspace_id).filled

        required(:name).filled(:str?)
        required(:url).filled(:str?)

        required(:events).each(:str?)
        required(:active).filled(:bool?)

        optional(:ping_url).filled(:str?)
        optional(:test_url).filled(:str?)
        optional(:secret).filled(:str?)
      end
    end

    representer :render, Webhook::Representer::Show

    def model!(options, params:, **)
      options['model'] = Webhook.new(params.slice(:workspace_id))
    end

    def type
      :webhook
    end
  end
end
