class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|
      t.string 'origin'
      t.string 'owner'
      t.string 'title'
      t.float 'amount'
      t.date 'date'
      t.timestamps
    end
  end
end
