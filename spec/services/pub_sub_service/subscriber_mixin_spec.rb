require 'rails_helper'

RSpec.describe PubSubService::SubscriberMixin do
  subject(:subscriber_class) do
    Class.new do
      include PubSubService::SubscriberMixin
    end
  end

  it { is_expected.to respond_to(:on_event).with(1).argument }
end
