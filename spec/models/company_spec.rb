require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of(:name) }
  # bug in shoulda-matchers gem
  # https://github.com/thoughtbot/shoulda-matchers/issues/830
  # it { should validate_uniqueness_of(:name) }
  it { should have_many(:users) }
  it { should have_many(:projects) }
end
