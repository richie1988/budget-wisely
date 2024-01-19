require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    expect(user).to be_invalid
  end

  it 'is invalid without a valid email' do
    user = build(:user, email: 'invalid_email')
    expect(user).to be_invalid
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    expect(user).to be_invalid
  end

  it 'is invalid with a short password' do
    user = build(:user, password: 'short')
    expect(user).to be_invalid
  end

  it 'is invalid with a common password' do
    user = build(:user, password: 'password')
    expect(user).to be_invalid
  end

  it 'is invalid with a password containing spaces' do
    user = build(:user, password: 'password with spaces')
    expect(user).to be_invalid
  end
end
