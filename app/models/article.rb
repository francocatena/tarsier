class Article < ActiveRecord::Base
  # Scopes
  scope :ordered_list, order('name ASC')
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :code, :price, :description, :brand_id, :lock_version
  
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
  
  def to_s
    "[#{self.code}] #{self.name}"
  end
end
