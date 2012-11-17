class Review
  include Mongoid::Document
  belongs_to :thing
  belongs_to :user

  field :note, type: String
  field :ob_score, type: Integer
  field :sub_score, type: Integer

  attr_accessible :note, :ob_score, :sub_score
  validates_presence_of :ob_score, :sub_score
end
