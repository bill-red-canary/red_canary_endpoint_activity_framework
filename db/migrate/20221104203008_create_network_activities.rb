class CreateNetworkActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :network_activities do |t|
      t.text :data
      t.string :data_protocol
      t.integer :data_size
      t.string :destination_address
      t.integer :destination_port
      t.belongs_to :endpoint_process, null: false, foreign_key: true
      t.string :url, null: false
      t.string :source_address
      t.integer :source_port

      t.timestamps
    end
  end
end
