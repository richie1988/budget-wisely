class Expense < ApplicationRecord
  belongs_to :user
  has_many :group_entities, dependent: :destroy, autosave: true
  has_many :categories, through: :group_entities

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :must_have_at_least_one_category

  def self.most_recent(user, limit = nil)
    limit ||= user.expenses.count
    where(user:).order(created_at: :desc).limit(limit)
  end

  def self.most_ancient(user, limit = nil)
    limit ||= user.expenses.count
    where(user:).order(created_at: :asc).limit(limit)
  end

  def self.expenses_by_user(user)
    where(user:).order(created_at: :desc)
  end

  private

  def must_have_at_least_one_category
    errors.add(:categories, 'must have at least one category') if group_entities.empty?
  end
end
