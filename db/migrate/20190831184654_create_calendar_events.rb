class CreateCalendarEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :calendar_events do |t|
      t.string :name
      t.string :category
      t.string :icon
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
