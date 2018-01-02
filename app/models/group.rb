class Group < ApplicationRecord

  validates :name, presence: true

  has_many :usergroups, inverse_of: :group

  has_many :users, through: :usergroups

  accepts_nested_attributes_for :usergroups,allow_destroy: true, reject_if: proc { |attributes| attributes['user_ids'].blank? }

end
