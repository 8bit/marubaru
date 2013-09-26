class Type
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :things
  belongs_to :owner, polymorphic: true

  field :name, type: String
  field :description, type: String
  field :image, type: String
  field :active, type: Boolean

  attr_accessible :name, :description
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  def self.lookup(query)
  	name = Type.any_of({ :name => /.*#{query}.*/i })
  	if name.empty?
  		[{id: "#{query}", name: "New: \"#{query}\""}]
  	else
      name
  	end
  end
end
