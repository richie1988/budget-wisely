FactoryBot.define do
  factory :expense do
    name { 'Sample Expense' }
    amount { 10.0 }
    user
    category { association(:category) }
  end
end
