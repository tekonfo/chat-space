class Group < ApplicationRecord
  validates :name, presence: true
  has_many :usergroups, dependent: :destroy
  has_many :users, through: :usergroups
  accepts_nested_attributes_for :usergroups, allow_destroy: true,reject_if: :reject_posts

  def reject_posts(attributed)
    attributed['user_ids'].blank?
  end

end
