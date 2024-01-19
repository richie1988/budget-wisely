require 'rails_helper'

RSpec.describe ExpensesController, type: :routing do
  describe 'routing' do
    let(:user) { create(:user) } # Assuming you have a user factory

    it 'routes to #index' do
      expect(get: "/users/#{user.id}/expenses").to route_to('expenses#index', user_id: user.id.to_s)
    end

    it 'routes to #new' do
      expect(get: "/users/#{user.id}/expenses/new").to route_to('expenses#new', user_id: user.id.to_s)
    end

    it 'routes to #show' do
      expect(get: "/users/#{user.id}/expenses/1").to route_to('expenses#show', id: '1', user_id: user.id.to_s)
    end

    it 'routes to #edit' do
      expect(get: "/users/#{user.id}/expenses/1/edit").to route_to('expenses#edit', id: '1', user_id: user.id.to_s)
    end

    it 'routes to #create' do
      expect(post: "/users/#{user.id}/expenses").to route_to('expenses#create', user_id: user.id.to_s)
    end

    it 'routes to #update via PUT' do
      expect(put: "/users/#{user.id}/expenses/1").to route_to('expenses#update', id: '1', user_id: user.id.to_s)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/users/#{user.id}/expenses/1").to route_to('expenses#update', id: '1', user_id: user.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}/expenses/1").to route_to('expenses#destroy', id: '1', user_id: user.id.to_s)
    end
  end
end
