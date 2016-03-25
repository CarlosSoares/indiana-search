require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should belong_to(:company) }
  it { should have_many(:projects) }
  it { should have_many(:consumers) }
  it { should have_many(:searches) }

  it 'does has the right devise modules' do
    modules = [:database_authenticatable, :rememberable, :recoverable,
               :registerable, :validatable, :trackable]

    expect(User.devise_modules).to eql(modules)
  end

  describe '#ensure_authentication_token' do
    context 'when authentication_token is empty' do
      it 'should call generate_authentication_token' do
        expect_any_instance_of(User).to receive(:generate_authentication_token).and_return('newtoken')
        create(:user)
      end
    end
    context 'when authentication_token is present' do
      it 'should do nothing' do
        expect_any_instance_of(User).not_to receive(:generate_authentication_token).and_return('newtoken')
        create(:user, authentication_token: 'token')
      end
    end
  end

  describe '#generate_authentication_token' do
    it 'should generate a token' do
      expect(user.send(:generate_authentication_token).present?).to eql(true)
    end
  end
end
