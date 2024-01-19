RSpec.describe ExpensesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'GET #show' do
    it 'assigns the requested expense as @expense' do
      get :show, params: { user_id: user.id, id: 0 }
      expect(assigns(:expense)).to eq(nil)
    end
  end

  describe 'GET #new' do
    it 'assigns a new expense as @expense' do
      get :new, params: { user_id: user.id }
      expect(assigns(:expense)).to eq(nil)
    end
  end

  describe 'POST #create' do
    it 'creates a new expense' do
      expect do
        post :create,
             params: { user_id: user.id, expense: { name: 'Expense', amount: 0, user_id: 0, category_ids: [0] } }
      end.to change(Expense, :count).by(0)
    end
  end

  describe 'PUT #update' do
    it 'updates the requested expense' do
      put :update, params: { user_id: user.id, id: 0, expense: { name: 'Updated Expense' } }
      expect(assigns(:expense)).to eq(nil)
    end
  end
end
