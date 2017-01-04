require 'rails_helper'

RSpec.describe PubSubService::PublisherMixin do
  let(:publisher_class) do
    Class.new do
      include PubSubService::PublisherMixin
    end
  end

  subject(:publisher) { publisher_class.new }

  it { is_expected.to respond_to(:emit).with(1).argument }
end
