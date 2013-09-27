class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :thing
  belongs_to :user

  field :thought, type: String
  field :ob_score, type: Integer
  field :sub_score, type: Integer

  attr_accessible :thought, :ob_score, :sub_score
  validates_presence_of :ob_score, :sub_score
end
