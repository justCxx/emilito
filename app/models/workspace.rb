class Workspace < ApplicationRecord
  belongs_to :account
  has_many :tickets
  has_many :webhooks
end
