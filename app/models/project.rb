# Project ActiveRecord
class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :company_id, allow_blank: false }
  after_create :set_namespace

  belongs_to :company
  has_many :consumers
  has_many :searches, through: :consumers

  def project_data_info
    @project_data_info ||= ElasticSearchApi.info(namespace)
  end

  private

  def set_namespace
    update_attributes(namespace: "company_#{company.id}_project_#{id}")
  end
end
