class Tag < ActiveRecord::Base
  include Comparable
  
  # Scopes
  scope :ordered_list, order('name ASC')
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name
  
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false },
    length: { maximum: 255 }
  
  def to_s
    self.name
  end
  
  def <=>(other)
    self.name <=> other.name
  end
  
  def as_json(options = nil)
    default_options = { only: [:name] }
    
    super(default_options.merge(options || {}))
  end
end
