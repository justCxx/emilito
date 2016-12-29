module WebAuth
  class JsonWebToken
    extend Dry::Configurable

    setting :secret_key, Rails.application.secrets.secret_key_base

    class << self
      def encode(data)
        JWT.encode(data, config.secret_key)
      end

      def decode(data)
        JWT.decode(data, config.secret_key)[0]
      end
    end
  end
end
