require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }
  let(:project) { create(:project, company: company) }

  before(:each) do
    sign_in user

    create_list(:project, 10, company: company)
  end

  describe 'GET #index' do
    it 'does render projects' do
      get :index

      expect(assigns(:projects)).to eq(user.projects)
    end

    it 'does be success' do
      get :index

      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:project) }

      it 'does creates a new' do
        expect do
          post :create, project: valid_attributes
        end.to change(user.projects, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does render the new template' do
        post :create, project: { name: '' }

        expect(response).to render_template('new')
      end

      it 'does render the new template with same name' do
        post :create, project: { name: project.name }

        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'does assigns project' do
      get :show, id: project.id

      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'GET #edit' do
    it 'does assigns project' do
      get :edit, id: project.id

      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'GET #new' do
    it 'does assigns an new project' do
      get :new

      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'does updates the requested project' do
        put :update, id: project.id, project: { name: 'testtest123' }

        expect(project.reload.name).to eql('testtest123')
      end

      it 'does be redirect' do
        put :update, id: project.id, project: { name: 'testtest123' }

        expect(response).to be_redirect
      end
    end

    context 'with invalid params' do
      it 'does render edit' do
        put :update, id: project.id, project: { name: '' }

        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested project' do
      delete :destroy, id: project.id

      expect(Project.find_by(id: project.id)).to be_nil
    end

    it 'does be redirect' do
      delete :destroy, id: project.id

      expect(response).to be_redirect
    end
  end
end
