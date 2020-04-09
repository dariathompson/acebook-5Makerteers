require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET /new " do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /" do
    let(:user) { User.create(name: "name", email: "email@mail.com", password: "password" )}
    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end
    it "responds with 200" do
      post :create, params: { post: { message: "Hello, world!" } }
      expect(response).to redirect_to(posts_url)
    end
  end
  
  describe "create post" do
    let(:user) { User.create(name: "name", email: "email@mail.com", password: "password" )}
    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end
    
    it "should create" do 
    expect {
      post :create, params: { post: { message: "new post" } }
    }.to change(Post, :count).by(1)
    end
  end

#   describe "POST /new " do
#     it "will not let you create a post if you are not signed in" do 
#     post :create, params: { post: { message: "Hello, world!" } }
#     expect(response).to redirect_to(roots_url)
#   end
# end

  describe "GET /" do
    it "responds with 200" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /" do

    let(:user) { User.create(name: "name", email: "email@mail.com", password: "password" )}
    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end

    it "updates a post" do

      post = Post.create({ message: "Hello world!" })
      patch :update, params: { id: "#{post.id}", post: { message: "Hello, everyone!" } }
      p Post.find_by(id: "#{post.id}")
      # p Post.find_by(id: 1).messsage
      expect(Post.find_by(id: "#{post.id}").message).not_to eq "Hello, world!"
      expect(Post.find_by(id: "#{post.id}").message).to eq "Hello, everyone!"
    end
  end

end
