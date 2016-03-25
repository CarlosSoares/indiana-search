require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:consumer) }

      it 'does creates a new' do
        expect do
          post :create, user: {
            company_attributes: { name: 'Company 1' },
            email: 'example@example.com',
            password: 'example1234!',
            password_confirmation: 'example1234!'
          }
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does render the new template' do
        post :create, {}

        expect(response).to render_template('new')
      end
    end
  end
end
