class Consumer < ActiveRecord::Base
  belongs_to :project
  validates :name, presence: true
  validates :project_id, presence: true

  before_create :set_token

  private
    def set_token
      return if token.present?
      self.token = generate_auth_token
    end

    def generate_auth_token
      SecureRandom.uuid.gsub(/\-/,'')
    end
end
