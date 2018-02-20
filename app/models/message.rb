class Message < ApplicationRecord

  validates :text_or_image, presence: true
  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader


  def time
    updated_at.strftime("%Y年%m月%d日 %H時%M分")
  end

  private

  def text_or_image
    text.presence or image.presence
  end
end
