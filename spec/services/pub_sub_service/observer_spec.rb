require 'rails_helper'

RSpec.describe PubSubService::Observer do
  subject { PubSubService::Observer }
  it { is_expected.to respond_to(:process_event).with(1).argument }
end
