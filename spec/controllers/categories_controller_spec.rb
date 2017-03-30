require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let(:valid_attributes) {
    { name: 'new category name', description: 'new category description' }
  }

  let(:invalid_attributes) {
    { name: 'new category name only' }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all categories as @categories" do
      category = Category.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET #show" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :show, id: category.to_param, session: valid_session
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #new" do
    it "assigns a new category as @category" do
      get :new, params: {}, session: valid_session
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET #edit" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :edit, id: category.to_param, session: valid_session
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, category: valid_attributes, session: valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, category: valid_attributes, session: valid_session
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, category: valid_attributes, session: valid_session
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, category: invalid_attributes, session: valid_session
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, category: invalid_attributes, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'a new name', description: 'this is a new desc' }
      }

      it "updates the requested category" do
        category = Category.create! valid_attributes
        put :update, id: category.to_param, category: new_attributes, session: valid_session
        category.reload
        expect(assigns(:category)[:name]).to eq(new_attributes[:name])
        expect(assigns(:category)[:description]).to eq(new_attributes[:description])
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, id: category.to_param, category: valid_attributes, session: valid_session
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, id: category.to_param, category: valid_attributes, session: valid_session
        expect(response).to redirect_to(category)
      end
    end

    context "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        put :update, id: category.to_param, category: invalid_attributes, session: valid_session
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Category.create! valid_attributes
        put :update, id: category.to_param, category: { name: nil }, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, id: category.to_param, session: valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, id: category.to_param, session: valid_session
      expect(response).to redirect_to(categories_url)
    end
  end

end
