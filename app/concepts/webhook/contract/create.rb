require 'reform/form/dry'

class Webhook
  module Contract
    class Create < Webhook::Contract::Base
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
      end
    end
  end
end
