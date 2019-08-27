class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.string :description
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
