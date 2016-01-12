require 'test_helper'

class ConsumerTest < ActiveSupport::TestCase

  setup do
    user      = FactoryGirl.create(:user)
    project   = FactoryGirl.create(:project)
    @consumer = FactoryGirl.create(:consumer, name: 'Test',project_id: project.id)
  end

  test "should generate token on creation" do
    assert_not_empty @consumer.token
  end

end
