class Leader < ApplicationRecord
  has_many :nominees
  belongs_to :admin,optional: true
  serialize :made_at,::Hash
  mount_uploader :docf, ImageUploader
  mount_uploader :docb, ImageUploader
 
end
