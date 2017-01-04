module WebhookService
  class HttpClient
    def self.call(url, data = {}, options = {})
      new.request(:post, url, data, options)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.response :logger, Rails.logger, bodies: true
        conn.adapter  Faraday.default_adapter
      end
    end

    def request(method, url, data = {}, options = {})
      response = connection.send method, url do |req|
        req.body = data
        req.headers.update options[:headers]
      end

      [response.status, response.headers, response.body]
    end
  end
end
