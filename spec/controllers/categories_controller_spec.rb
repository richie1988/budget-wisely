require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: 'Sample Category', user: } }
  let(:category) { create(:category, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all categories as @categories' do
      get :index
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested category as @category' do
      get :show, params: { id: category.to_param }
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'GET #new' do
    it 'assigns a new category as @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Category' do
        expect do
          post :create, params: { category: attributes_for(:category) }
        end.to change(Category, :count).by(1)
      end

      it 'assigns a newly created category as @category' do
        post :create, params: { category: attributes_for(:category) }
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved category as @category' do
        post :create, params: { category: attributes_for(:category, name: nil) }
        expect(assigns(:category)).to be_a_new(Category)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New Category Name' } }

      it 'updates the requested category' do
        put :update, params: { id: category.to_param, category: new_attributes }
        category.reload
        expect(category.name).to eq('New Category Name')
      end

      it 'assigns the requested category as @category' do
        put :update, params: { id: category.to_param, category: new_attributes }
        expect(assigns(:category)).to eq(category)
      end
    end

    context 'with invalid params' do
      it 'assigns the category as @category' do
        put :update, params: { id: category.to_param, category: { name: nil } }
        expect(assigns(:category)).to eq(category)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category = create(:category, user:)
      expect do
        delete :destroy, params: { id: category.to_param }
      end.to change(Category, :count).by(-1)
    end
  end
end
