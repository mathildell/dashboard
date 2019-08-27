json.extract! expense, :id, :title, :description, :amount, :date, :created_at, :updated_at
json.url expense_url(expense, format: :json)
