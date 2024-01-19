class Category < ApplicationRecord
  after_initialize :set_default_icon, if: :new_record?
  belongs_to :user
  has_many :group_entities
  has_many :expenses, through: :group_entities
  has_one_attached :icon

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validate :valid_icon_format

  before_validation :set_default_icon

  def self.descending_order_for_user(user)
    where(user:).order(created_at: :desc)
  end

  private

  def valid_icon_format
    return unless icon.attached? && icon.blob.present?

    allowed_formats = %w[image/png image/gif image/jpeg image/jpg image/svg+xml]
    return if allowed_formats.include?(icon.blob.content_type)

    errors.add(:icon, 'Field only accepts png, gif, jpeg, jpg, or svg.')
  end

  def set_default_icon
    self.icon ||= 'icon-home.png'
  end
end
