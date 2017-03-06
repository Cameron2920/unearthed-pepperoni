class Image < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_attached_file :image, styles: { origianl: [:png] }, default_url: "/images/:style/missing.png"
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def image_url
    self.image.url(:original)
  end
end
