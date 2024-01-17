class GroupEntity < ApplicationRecord
  belongs_to :expense
  belongs_to :category
end