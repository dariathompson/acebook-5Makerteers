# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { User.create(name: 'name', username: 'username', email: 'email@mail.com', password: 'password') }
  describe 'GET /new ' do
    it 'responds with 200' do
      sign_in
      get :new
      expect(response).to have_http_status(200)
    end
    it 'blocks unauthenticated access' do
      sign_in nil

      get :new

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      sign_in(user)
      post :create, params: { post: { message: 'Hello, world!', wall_id: 0 } }

      expect(response).to redirect_to('/users/0')
    end
  end

  describe 'create post' do
    it 'should create' do
      sign_in(user)
      expect do
        post :create, params: { post: { message: 'Hello, world!', wall_id: 0 } }
      end.to change(Post, :count).by(1)
    end
  end

  describe 'POST /new ' do
    it 'will not let you create a post if you are not signed in' do
      post :create, params: { post: { message: 'Hello, world!', wall_id: 0 } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /' do
    it 'responds with 200' do
      sign_in
      get :index
      expect(response).to have_http_status(200)
    end
    it 'blocks unauthenticated access' do
      sign_in nil

      get :index

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PATCH /' do
    let(:current_user) { user }

    it 'updates a post' do
      sign_in(user)
      post = current_user.posts.create({ message: 'Hello world!' })
      patch :update, params: { id: post.id.to_s, post: { message: 'Hello, everyone!' } }
      expect(Post.find_by(id: post.id.to_s).message).not_to eq 'Hello, world!'
      expect(Post.find_by(id: post.id.to_s).message).to eq 'Hello, everyone!'
    end

    it 'cannot update a post after 10 minutes' do
      sign_in(user)
      @time_now = (Time.now + 601)
      allow(Time).to receive(:now).and_return(@time_now)

      post = current_user.posts.create({ message: 'Hello, world!' })
      get :edit, params: { id: post.id.to_s, post: { message: 'Hello, everyone!' } }
      expect(Post.find_by(id: post.id.to_s).message).not_to eq 'Hello, everyone!'
      expect(Post.find_by(id: post.id.to_s).message).to eq 'Hello, world!'
    end
  end
end
