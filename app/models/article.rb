class Article < ActiveRecord::Base
  # Scopes
  scope :ordered_list, order('name ASC')
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :code, :price, :description, :brand_id, :tag_list,
    :lock_version
  
  # Validations
  validates :name, :code, :price, presence: true
  validates :code, uniqueness: { case_sensitive: false }, allow_nil: true,
    allow_blank: true
  validates :name, :code, length: { maximum: 255 }, allow_nil: true,
    allow_blank: true
  validates :price, numericality: { greater_than: 0 }, allow_nil: true,
    allow_blank: true
  
  # Relations
  belongs_to :brand
  has_and_belongs_to_many :tags
  
  def to_s
    "[#{self.code}] #{self.name}"
  end
  
  def tag_list
    self.tags.map(&:to_s).join(',')
  end
  
  def tag_list=(tags)
    tags = (tags || '').split(/\s*,\s*/).reject(&:blank?)
    
    # Remove the removed =)
    self.tags.delete *self.tags.reject { |t| tags.include?(t.name) }
    
    # Add or create and add the new ones
    tags.each do |tag|
      unless self.tags.map(&:name).include?(tag)
        self.tags << Tag.find_or_create_by_name(tag)
      end
    end
  end
end
