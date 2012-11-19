class Thing
  include Mongoid::Document
  has_many :reviews
  belongs_to :type

  field :name, type: String
  field :description, type: String
  #field :_id, type: String, default: ->{ name.to_s.parameterize }

  attr_accessible :name, :description
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  def self.lookup(query)
  	name = Thing.any_of({ :name => /.*#{query}.*/i })
  	if name.empty?
  		[{id: "#{query}", name: "New: \"#{query}\""}]
  	else
      name
  	end
  end
end
