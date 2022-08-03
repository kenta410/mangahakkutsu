class Tagmap < ApplicationRecord
  belongs_to :genre
  belongs_to :tag
end
