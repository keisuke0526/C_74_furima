class ItemImg < ApplicationRecord
  mount_uploader :image, ItemImgsUploader
  belongs_to :item
  
  validates :image, presence: true
end
