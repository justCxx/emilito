require 'rails_helper'
require 'web_auth/json_web_token'

describe WebAuth::JsonWebToken do
  describe '.config' do
    subject(:config)  { WebAuth::JsonWebToken.config }
    it_is_asserted_by { config.to_h.key? :secret_key }
  end

  describe '.encode' do
    it_is_asserted_by { WebAuth::JsonWebToken.encode('id' => 42) }
  end

  describe '.decode' do
    context 'when token generated from data' do
      let(:data) { { 'id' => 42 } }
      let(:token) { WebAuth::JsonWebToken.encode(data) }
      it_is_asserted_by { WebAuth::JsonWebToken.decode(token) == data }
    end
  end
end
