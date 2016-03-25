require 'rails_helper'

RSpec.describe ConsumersController, type: :controller do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }
  let(:project) { create(:project, company: company) }
  let(:consumer) { create(:consumer, project: project) }

  before(:each) do
    sign_in user

    create_list(:consumer, 10, project: project)
  end

  describe 'GET #index' do
    it 'does render consumers' do
      get :index, project_id: project.id

      expect(assigns(:consumers)).to eq(project.consumers)
    end

    it 'does be success' do
      get :index, project_id: project.id

      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:consumer) }

      it 'does creates a new' do
        expect do
          post :create, project_id: project.id, consumer: valid_attributes
        end.to change(project.consumers, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does render the new template' do
        post :create, project_id: project.id, consumer: { name: '' }

        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'does assigns consumer' do
      get :show, id: consumer.id, project_id: project.id

      expect(assigns(:consumer)).to eq(consumer)
    end
  end

  describe 'GET #edit' do
    it 'does assigns consumer' do
      get :edit, id: consumer.id, project_id: project.id

      expect(assigns(:consumer)).to eq(consumer)
    end
  end

  describe 'GET #new' do
    it 'does assigns an new consumer' do
      get :new, project_id: project.id

      expect(assigns(:consumer)).to be_a_new(Consumer)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'does updates the requested consumer' do
        put :update, id: consumer.id, project_id: project.id, consumer: { name: 'testtest123' }

        expect(consumer.reload.name).to eql('testtest123')
      end

      it 'does be redirect' do
        put :update, id: consumer.id, project_id: project.id, consumer: { name: 'testtest123' }

        expect(response).to be_redirect
      end
    end

    context 'with invalid params' do
      it 'does render edit' do
        put :update, id: consumer.id, project_id: project.id, consumer: { name: '' }

        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested consumer' do
      delete :destroy, id: consumer.id, project_id: project.id

      expect(Consumer.find_by(id: consumer.id)).to be_nil
    end

    it 'does be redirect' do
      delete :destroy, id: consumer.id, project_id: project.id

      expect(response).to be_redirect
    end
  end
end
