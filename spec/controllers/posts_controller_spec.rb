require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET /new " do
    it "responds with 200" do
      sign_in
      get :new
      expect(response).to have_http_status(200)
    end
    it "blocks unauthenticated access" do
      sign_in nil
    
      get :new
    
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /" do
    let(:user) { User.create(name: "name", username: 'username', email: "email@mail.com", password: "password" )}
    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end
    it "responds with 200" do
      sign_in
      post :create, params: { post: { message: "Hello, world!", wall_id: 0 } }
      expect(response).to redirect_to("/users/0")
    end
  end
  
  describe "create post" do
    let(:user) { User.create(name: "name", username: 'username', email: "email@mail.com", password: "password" )}
    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end
    
    it "should create" do 
    expect {
      post :create, params: { post: { message: "new post", wall_id: 0 } }
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
      sign_in
      get :index
      expect(response).to have_http_status(200)
    end
    it "blocks unauthenticated access" do
      sign_in nil

      get :index
    
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH /" do

    let(:user) { User.create(name: "name", username: 'username', email: "email@mail.com", password: "password" )}
    let(:current_user) { user }
    # let(:plus_10) {now: (Time.now + 60*10)}
    

    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end

    it "updates a post" do

      post = current_user.posts.create({ message: "Hello world!" })
      patch :update, params: { id: "#{post.id}", post: { message: "Hello, everyone!" } }
      expect(Post.find_by(id: "#{post.id}").message).not_to eq "Hello, world!"
      expect(Post.find_by(id: "#{post.id}").message).to eq "Hello, everyone!"
    end

     it "cannot update a post after 10 minutes" do
      @time_now = (Time.now + 601)
      # allow_any_instance_of(PostsController).to receive(:Time.now){ plus_10 }
      allow(Time).to receive(:now).and_return(@time_now)

      post = current_user.posts.create({ message: "Hello, world!" })
      get :edit, params: { id: "#{post.id}", post: { message: "Hello, everyone!" } }
      expect(Post.find_by(id: "#{post.id}").message).not_to eq "Hello, everyone!"
      expect(Post.find_by(id: "#{post.id}").message).to eq "Hello, world!"
    end
  end

end
