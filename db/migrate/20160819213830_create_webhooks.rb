class CreateWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :webhooks do |t|
      t.string :name
      t.references :workspace, foreign_key: true
      t.text :url
      t.text :test_url
      t.text :ping_url
      t.string :events, array: true
      t.boolean :active

      t.timestamps
    end
  end
end
