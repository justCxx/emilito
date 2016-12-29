require 'rails_helper'

describe WebAuth::AuthenticationController do
  describe 'POST /auth_user' do
    subject(:response) { post :user_auth, params: params }

    context 'when parameters is valid' do
      let(:params) { { email: 'foo@bar.io', password: 'foobar' } }

      before do
        User.create(email: 'foo@bar.io', password: 'foobar')
      end

      it_is_asserted_by { response.status.to_i == 200 }
      it_is_asserted_by { response.content_type == 'application/json' }

      it_is_asserted_by { JSON.parse(response.body).key? 'auth_token' }
      it_is_asserted_by { JSON.parse(response.body).key? 'user' }
      it_is_asserted_by { JSON.parse(response.body)['user'].key? 'id' }
    end

    context 'when parameters are invalid' do
      let(:params) { { email: 'foo@bar.io', password: 'foobar' } }

      before do
        User.create(email: 'foo@bar.io', password: 'barfoo')
        User.create(email: 'bar@foo.io', password: 'foobar')
      end

      it_is_asserted_by { response.status.to_i == 403 }
      it_is_asserted_by { response.content_type == 'application/json' }
      it_is_asserted_by { response.body == '{}' }
    end
  end
end
