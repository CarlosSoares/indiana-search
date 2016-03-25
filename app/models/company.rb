# Company ActiveRecord
class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :users
  has_many :projects
end
