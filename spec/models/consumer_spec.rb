require 'rails_helper'

RSpec.describe Consumer, type: :model do
  let(:consumer) { create(:consumer) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:project_id) }
  # bug in shoulda-matchers gem
  # https://github.com/thoughtbot/shoulda-matchers/issues/830
  # it { should validate_uniqueness_of(:name) }
  it { should have_many(:searches) }

  describe '#track_search' do
    it 'should create an new search' do
      expect do
        consumer.track_search(table_name: 'clients', field: 'name', query: 'hi')
      end.to change(Search, :count).by(1)
    end
  end

  describe '#set_token' do
    context 'when token is empty' do
      it 'should call generate_token' do
        expect_any_instance_of(Consumer).to receive(:generate_token).and_return('newtoken')
        create(:consumer)
      end
    end
    context 'when token is present' do
      it 'should do nothing' do
        expect_any_instance_of(Consumer).not_to receive(:generate_token)
        create(:consumer, token: 'token')
      end
    end
  end

  describe '#generate_token' do
    it 'should generate a token' do
      expect(consumer.send(:generate_token).present?).to eql(true)
    end
  end
end
