# Consumer ActiveRecord
class Consumer < ActiveRecord::Base
  belongs_to :project

  validates :name, :project_id, presence: true
  validates :name, uniqueness: { scope: :project_id, allow_blank: false }

  before_create :set_token
  has_many :searches

  def track_search(params = {})
    searches.create(table_name: params[:table_name],
                    field: params[:field],
                    query: params[:query])
  end

  private

  def set_token
    self.token = generate_token if token.blank?
  end

  def generate_token
    loop do
      token = Devise.friendly_token
      break token unless Consumer.find_by(token: token)
    end
  end
end
