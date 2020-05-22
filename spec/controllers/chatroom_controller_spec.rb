require 'rails_helper'

RSpec.describe ChatroomController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      sign_in
      get :show
      expect(response).to have_http_status(:success)
    end
    it "blocks unauthenticated access" do
      sign_in nil
    
      get :show
    
    expect(response).to redirect_to(new_user_session_path)
  end
  end

end
