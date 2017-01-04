class Webhook
  module Representer
    class Show < Emilito::Representer::Base
      property :id
      property :name
      property :url
      property :ping_url
      property :test_url
      property :events
      property :active
      property :secret, render_filter: ->(*) { '*' * 7 }
      property :created_at
      property :updated_at
    end
  end
end
