class CreateWebhookDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :webhook_deliveries, id: :uuid do |t|
      t.references :webhook, foreign_key: true

      t.jsonb :request
      t.jsonb :response

      t.string :signature
      t.boolean :delivered

      t.timestamps
    end
  end
end
