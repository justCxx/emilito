class Webhook
  class Delivery < Emilito::Operation::Base
    Contract = Trailblazer::Operation::Contract

    contract WebhookDelivery::Contract::Create

    step :model!
    step Contract::Build()
    step Contract::Validate(key: :delivery)
    step Contract::Persist(method: :sync)
    step :build_headers!
    step :add_signature_header!
    step :delivery!
    step Contract::Persist()

    representer :render, WebhookDelivery::Representer::Show

    def model!(options, params:, **)
      options['model'] = WebhookDelivery.new(webhook_id: params[:id])
    end

    def build_headers!(_options, model:, params:, **)
      model.request['headers'].tap do |headers|
        # TODO: model.webhook.content_type
        headers['Content-Type'] = 'application/json'
        # TODO: options['user_agent']
        headers['User-Agent'] = 'Emilito-Hookshot'
        headers['X-Emilito-Delivery'] = model.id
        headers['X-Emilito-Event'] = params.dig(:delivery, :event) || ''
      end
    end

    def add_signature_header!(options, model:, **)
      return options unless model.webhook.secret

      require 'openssl'

      # TODO: sha1 = options['signature.class'].(secret, data)
      sha1 = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                                     model.webhook.secret,
                                     model.request['payload'].to_json)
      model.request['headers']['X-Emilito-Signature'] = "sha1=#{sha1}"
    end

    def delivery!(_options, model:, **)
      # TODO: options['http_client'].(:post, url, data, options)
      status, headers, body = WebhookService::HttpClient.(
        model.webhook.url,
        model.request['payload'],
        headers: model.request['headers']
      )

      model.response = {
        status: status, headers: headers, body: body
      }
    end
  end
end
