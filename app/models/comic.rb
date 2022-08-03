class Comic < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  validates :title, presence:true
  validates :synopsis, presence:true, length:{maximum: 200 }

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  def self.comics_search(search)
    Comic.where(['title LIKE(?) or text LIKE(?)', "%#{search}%", "%#{search}%"])
  end

  def save_comics(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

   # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

   # Create
    new_tags.each do |new_name|
     item_tag = Tag.find_or_create_by(tag_name:new_name)
     self.tags << item_tag
    enddef self.comics_search(search)
      Comic.where(['title LIKE(?) or text LIKE(?)', "%#{search}%", "%#{search}%"])
    end
  end

  def save_comics(tags)
   current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
   old_tags = current_tags - tags
   new_tags = tags - current_tags

   # Destroy
   old_tags.each do |old_name|
     self.tags.delete Tag.find_by(tag_name:old_name)
   end

   # Create
   new_tags.each do |new_name|
     item_tag = Tag.find_or_create_by(tag_name:new_name)
     self.tags << item_tag
   end
  end
end