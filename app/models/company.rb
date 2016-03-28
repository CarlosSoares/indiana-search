# Company ActiveRecord
class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :users
  has_many :projects
  has_many :consumers, through: :projects
  has_many :searches, through: :consumers

  def to_graph
    data = []
    consumers.map { |c| Search.to_graph(c) }.each do |graph|
      graph.each do |d|
        data.push(day: d[0], searches: d[1].to_i, consumer: d[2].to_i)
      end
    end
    data
  end

end
