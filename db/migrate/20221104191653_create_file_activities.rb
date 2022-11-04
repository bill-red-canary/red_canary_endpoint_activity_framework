class CreateFileActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :file_activities do |t|
      t.string :file_path
      t.integer :activity
      t.belongs_to :endpoint_process, null: false, foreign_key: true

      t.timestamps
    end
  end
end
