# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      expect(get: '/users/1').to route_to(controller: 'users', action: 'show', id: '1')
    end
  end
end
