class Tag < ApplicationRecord
  belongs_to :comic
  
  scope :merge_comics, -> (tags){ }
  
  def self.search_comics_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(tag_name: content)
    elsif method == 'forward'
      tags = Tag.where('tag_name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('tag_name LIKE ?', '%' + content)
    else
      tags = Tag.where('tag_name LIKE ?', '%' + content + '%')
    end
    
    return tags.inject(init = []) {|result, tag| result.push tag.comic}
    
  end
end