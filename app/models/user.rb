class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :usergroups
 has_many :groups,through: :usergroups
 has_many :messages

scope :search, -> (keyword,user_id){ where('name LIKE(?)', "%#{keyword}%").where.not(id: user_id).limit(20) }

end
