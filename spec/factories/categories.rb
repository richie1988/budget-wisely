FactoryBot.define do
  factory :category do
    name { 'Sample Category' }
    user { association(:user) }
  end
end
