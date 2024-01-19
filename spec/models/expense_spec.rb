# # spec/models/expense_spec.rb
# RSpec.describe Expense, type: :model do
#   let(:user) { create(:user) } # Assuming you have a user factory
#   let(:category) { create(:category) } # Assuming you have a category factory

#   it 'has a valid factory' do
#     expense = build(:expense, user: user, categories: [category])
#     expect(expense).to be_valid
#   end

#   it 'is invalid without a user' do
#     expense = build(:expense, user: nil, categories: [category])
#     expect(expense).to be_invalid
#   end

#   it 'is invalid without a category' do
#     expense = build(:expense, user: user, categories: [])
#     expect(expense).to be_invalid
#   end
# end
