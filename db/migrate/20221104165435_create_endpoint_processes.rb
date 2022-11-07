class CreateEndpointProcesses < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoint_processes do |t|
      t.text :command
      t.string :name
      t.integer :process_id
      t.datetime :start_time
      t.string :user_name

      t.timestamps
    end
  end
end
