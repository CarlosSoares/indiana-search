require 'rails_helper'

RSpec.describe Search, type: :model do
  it { should belong_to(:consumer) }
end
