class CreateHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :homes do |t|
      t.string 'name'
      t.string 'address'
      t.string 'photos'
      t.timestamps
    end
  end
end
