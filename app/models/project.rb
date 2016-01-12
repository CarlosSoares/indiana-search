class Project < ActiveRecord::Base
  acts_as_tenant(:company)

  validates_uniqueness_of :name
  after_create :set_namespace

  private

  def set_namespace
    update_attributes(namespace: "company_#{company.id}_project_#{id}")
  end
end
