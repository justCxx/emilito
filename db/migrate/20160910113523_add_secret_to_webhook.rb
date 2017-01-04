class AddSecretToWebhook < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :secret, :string
  end
end
