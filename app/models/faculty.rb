class Faculty < ApplicationRecord
    # Relationships
    belongs_to :department
    has_many :assignments
    has_many :courses, through: :assignments
  
    # Scopes
    scope :alphabetical, -> { order(:last_name, :first_name) }
    scope :active, -> { where(active: true) }
  
    # Validations
    validates_presence_of :first_name, :last_name
    validates_inclusion_of :rank, in: ['Assistant Professor', 'Associate Professor', 'Professor']
end