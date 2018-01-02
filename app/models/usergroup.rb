class Usergroup < ApplicationRecord
  belongs_to :user
  belongs_to :group, inverse_of: :usergroups
end
