class Webhook
  class Delete < Trailblazer::Operation
    include Model
    model Webhook, :find

    def process(params)
      validate(params) do
        model.destroy
      end
    end
  end
end
