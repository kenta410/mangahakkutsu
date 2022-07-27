class Comic < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  validates :title, presence:true
  validates :synopsis, presence:true, length:{maximum: 200 }

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Comic.where(title: content)
    elsif method == 'forward'
      Comic.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Comic.where('title LIKE ?', '%' + content)
    else
      Comic.where('title LIKE ?', '%' + content + '%')
    end
  end

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
