class Type
  include Mongoid::Document
  has_many :things

  field :name, type: String
  field :description, type: String
  #field :_id, type: String, default: ->{ name.to_s.parameterize }

  attr_accessible :name, :description
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
