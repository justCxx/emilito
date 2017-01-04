class Webhook
  class Update < Webhook::Create
    contract do
      property :workspace_id, writeable: false

      property :add_events,
               virtual: true,
               setter: ->(represented:, fragment:, **) {
                 represented.events += fragment
               }

      property :remove_events,
               virtual: true,
               setter: ->(represented:, fragment:, **) {
                 represented.events -= fragment
               }

      validation do
        optional(:add_events).each(:str?)
        optional(:remove_events).each(:str?)
      end
    end

    def model!(options, params:, **)
      options['model'] = Webhook.find_by(id: params[:id])
    end
  end
end
