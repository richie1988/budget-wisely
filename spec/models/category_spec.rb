require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) } # Assuming you have a user factory

  it 'has a valid factory' do
    category = build(:category, user:)
    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category = build(:category, user:, name: nil)
    expect(category).to be_invalid
  end

  it 'validates the uniqueness of name scoped to user' do
    existing_category = create(:category, user:)
    category = build(:category, user:, name: existing_category.name)
    expect(category).to be_invalid
  end

  it 'belongs to a user' do
    category = build(:category, user: nil)
    expect(category).to be_invalid
  end

  # Add more tests for other validations and methods as needed
end
