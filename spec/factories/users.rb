# In your factories or specs

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:email) { |n| "john.doe#{n}@example.com" }
    password { 'Password123!' }
  end
end
