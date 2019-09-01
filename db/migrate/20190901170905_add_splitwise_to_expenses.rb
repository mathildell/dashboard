class AddSplitwiseToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :is_splitwise, :boolean
    add_column :expenses, :owner, :string
  end
end
