require 'rails_helper'

RSpec.describe Api::V1::SearchController, type: :controller do
  let(:consumer) { create(:consumer) }

  it { expect(Api::V1::SearchController).to be < BaseApiController }

  describe 'GET #index' do
    context 'with right token' do
      before(:each) do
        request.headers['Authorization'] = "Bearer #{consumer.token}"
      end

      it 'does render consumers' do
        expect(ElasticSearchApi).to receive(:search).with(consumer.project.namespace,
                                                          'clients', 'name', 'ola').and_return(results: [])
        get :index, table_name: 'clients', field: 'name', query: 'ola'

        expect(JSON.parse(response.body)).to eq('results' => [])
      end

      it 'does be success' do
        expect(ElasticSearchApi).to receive(:search).with(consumer.project.namespace,
                                                          'clients', 'name', 'ola').and_return(results: [])
        get :index, table_name: 'clients', field: 'name', query: 'ola'

        expect(response).to be_success
      end
    end

    context 'without the right token' do
      it 'should return bad request' do
        get :index, table_name: 'clients', field: 'name', query: 'ola'

        expect(response.body).to eq({ 'message' => 'Bad credentials' }.to_json)
      end
    end
  end
end
