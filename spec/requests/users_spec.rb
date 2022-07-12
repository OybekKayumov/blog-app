require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before(:example) { get '/users' }
    it 'should return success' do
      expect(response).to have_http_status(:ok)
    end
    it 'should render index template' do
      expect(response).to render_template('index')
    end
    it 'include the correct text' do
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /show' do
    before(:example) { get '/users/:id' }
    it 'should return success' do
      expect(response).to have_http_status(:ok)
    end
    it 'should render show template' do
      expect(response).to render_template('show')
    end
    it 'include the correct text' do
      expect(response.body).to include('Details of the user')
    end
  end
end
