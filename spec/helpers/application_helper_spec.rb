require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#cp' do
    it 'returns active class' do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.cp('/projects')).to eq('active')
    end
    it 'returns nothing' do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.cp('/projects')).to eq(nil)
    end
  end
end
