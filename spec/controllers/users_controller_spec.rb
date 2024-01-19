RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :create, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(User.last)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      get :show, params: { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user_to_delete = User.create! attributes_for(:user)
      sign_in user
      expect do
        delete :destroy, params: { id: user_to_delete.to_param }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user_to_delete = User.create! attributes_for(:user)
      sign_in user
      delete :destroy, params: { id: user_to_delete.to_param }
      expect(response).to redirect_to(users_url)
    end
  end
end
