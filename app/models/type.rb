class Type
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  attr_accessible :name, :description
  validates_presence_of :name
end
