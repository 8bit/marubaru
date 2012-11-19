class Type
  include Mongoid::Document
  has_many :things

  field :name, type: String
  field :description, type: String
  field :owner_id, type: Integer
  #field :_id, type: String, default: ->{ name.to_s.parameterize }

  attr_accessible :name, :description, :owner
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
