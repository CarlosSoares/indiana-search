class Consumer < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true
  validates :project_id, presence: true
  validates :name, uniqueness: { scope: :project_id, allow_blank: false }

  before_create :set_token
  has_many :searches

  def track_search params
    searches.create(table_name: params[:table_name],
                    field: params[:field],
                    query: params[:query])
  end

  private
    def set_token
      return if token.present?
      self.token = generate_auth_token
    end

    def generate_auth_token
      SecureRandom.uuid.gsub(/\-/,'')
    end
end
