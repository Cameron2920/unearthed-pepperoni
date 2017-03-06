class Equipment < ApplicationRecord
  belongs_to :equipment_type
  has_many :components
  has_many :images, as: :parent
end
