require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }
  let(:project) { create(:project, company: company) }
  let(:consumer) { create(:consumer, project: project) }

  before(:each) do
    sign_in user

    create_list(:search, 10, consumer: consumer)
    create_list(:search, 10, consumer: create(:consumer, project: project))
  end

  describe 'GET #index' do
    context 'without project id' do
      it 'does render consumers' do
        get :index

        expect(assigns(:searches)).to eq(user.searches)
      end

      it 'does be success' do
        get :index

        expect(response).to be_success
      end
    end

    context 'with project id' do
      it 'does render consumers' do
        get :index, project_id: project.id

        expect(assigns(:searches)).to eq(project.searches)
      end

      it 'does be success' do
        get :index, project_id: project.id

        expect(response).to be_success
      end
    end
  end
end
