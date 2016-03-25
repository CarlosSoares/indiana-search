require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { create(:project) }
  it { should validate_presence_of(:name) }
  # bug in shoulda-matchers gem
  # https://github.com/thoughtbot/shoulda-matchers/issues/830
  # it { should validate_uniqueness_of(:name) }
  it { should belong_to(:company) }
  it { should have_many(:consumers) }
  it { should have_many(:searches) }

  describe 'should set namespace after create' do
    it 'should update project namespace' do
      expect(project.reload.namespace).to eql("company_#{project.company_id}_project_#{project.id}")
    end
  end
end
