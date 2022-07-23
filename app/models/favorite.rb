class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :comic
  validates_uniqueness_of :comic_id, scope: :customer_id
end
