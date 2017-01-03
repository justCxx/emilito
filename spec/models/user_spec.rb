require 'rails_helper'

RSpec.describe User do
  describe '#avatar' do
    let(:user) { create(:user) }
    let(:fixtures_path) { 'spec/fixtures/images/avatars' }

    context 'wnen user not select avatar' do
      it_is_asserted_by { user.avatar.nil? }
    end

    context 'when user select avatar from file' do
      it do
        user.avatar = File.open("#{fixtures_path}/jocos.png")
        user.save
        is_asserted_by { user.avatar }
      end
    end

    context "when avatar set from 'data: URL' (RFC 2397)" do
      it do
        data = File.read("#{fixtures_path}/jocos_data_uri_png.txt")
        user.avatar_data_uri = data
        user.save
        is_asserted_by { user.avatar }
      end
    end
  end
end
