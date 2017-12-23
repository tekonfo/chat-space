class Group < ApplicationRecord
  validates :name, presence: true
  has_many :usergroups
  has_many :users,through: :group_users
  accepts_nested_attributes_for :usergroups, allow_destroy: true

end
