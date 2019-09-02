class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string 'name'
      t.string 'photo'
      t.date 'birthday'
      t.belongs_to :home

      t.timestamps
    end
  end
end
