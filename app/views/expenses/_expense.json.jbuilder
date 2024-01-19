json.extract! expense, :id, :name, :amount, :created_at, :category_id, :user_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
