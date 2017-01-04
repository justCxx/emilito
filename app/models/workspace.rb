class Workspace < ApplicationRecord
  belongs_to :account
  has_many :tickets, dependent: :destroy
  has_many :webhooks
end
