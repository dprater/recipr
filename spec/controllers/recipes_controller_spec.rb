require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  let(:valid_attributes) {
    { name: 'some new recipe', description: 'some new description', 
      instructions: 'some new instructions' }
  }

  let(:invalid_attributes) {
    { name: 'some new invalid recipe' }
  }

  let!(:cat1) { Category.create!(name: 'cat1', description: 'test category 1') }
  let!(:cat2) { Category.create!(name: 'cat2', description: 'test category 2') }

  let(:valid_session) { {} }

	describe "GET #search" do
		it "returns json from a valid search" do
			recipe = Recipe.new valid_attributes
      recipe.categories.push cat1
      recipe.save!
			get :search, params: { query: valid_attributes[:name] }, session: valid_session
			expect(assigns(:result)).to eq [{val: 1, label: recipe.name}]
		end
	end

  describe "GET #index" do
    it "assigns up to 3 recipes as @recipes" do
      recipe = Recipe.new valid_attributes
      recipe.categories.push cat1
      recipe.save!
      get :index, params: {}, session: valid_session
      expect(assigns(:recipes)).to eq([recipe])
		end
  end

  describe "GET #show" do
    it "assigns the requested recipe as @recipe" do
      recipe = Recipe.new valid_attributes
      recipe.categories.push cat1
      recipe.save! 
      get :show, id: recipe.id, session: valid_session
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "GET #new" do
    it "assigns a new recipe as @recipe" do
      get :new, params: {}, session: valid_session
      expect(assigns(:recipe)).to be_a_new(Recipe)
			expect(assigns(:categories)).to match_array ([cat1.name, cat2.name])
    end
  end

  describe "GET #edit" do
    it "assigns the requested recipe as @recipe" do
      recipe = Recipe.new valid_attributes
      recipe.categories.push cat1
      recipe.save!
			get :edit, id: recipe.id, session: valid_session
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, recipe: valid_attributes.merge(category_name: cat1.name), session: valid_session
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created recipe as @recipe" do
        post :create, recipe: valid_attributes.merge(category_name: cat1.name), session: valid_session
        expect(assigns(:recipe)).to be_a(Recipe)
        expect(assigns(:recipe)).to be_persisted
      end

      it "redirects to the created recipe" do
        post :create, recipe: valid_attributes.merge(category_name: cat1.name), session: valid_session
        expect(response).to redirect_to(Recipe.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved recipe as @recipe" do
        post :create, recipe: invalid_attributes, session: valid_session
        expect(assigns(:recipe)).to be_a_new(Recipe)
      end

      it "re-renders the 'new' template" do
        post :create, recipe: invalid_attributes, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'a new name', description: 'a new description', instructions: 'new instructions', category_name: 'cat2' }
      }

      it "updates the requested recipe" do
        recipe = Recipe.new valid_attributes
				recipe.categories.push cat1
				recipe.save!
        put :update, id: recipe.to_param, recipe: new_attributes, session: valid_session
        recipe.reload
        expect(assigns(:recipe).name).to eq(new_attributes[:name])
        expect(assigns(:recipe).categories.last.name).to eq('cat2')
        expect(assigns(:recipe).categories.count).to eq(2)
      end

      it "assigns the requested recipe as @recipe" do
        recipe = Recipe.new valid_attributes
        recipe.categories.push cat1
        recipe.save!
				put :update, id: recipe.to_param, recipe: valid_attributes, session: valid_session
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "redirects to the recipe" do
				recipe = Recipe.new valid_attributes
        recipe.categories.push cat1
        recipe.save!
        put :update, id: recipe.to_param, recipe: valid_attributes, session: valid_session
        expect(response).to redirect_to(recipe)
      end
    end

    context "with invalid params" do
      it "assigns the recipe as @recipe" do
        recipe = Recipe.new valid_attributes
        recipe.categories.push cat1
        recipe.save!
				put :update, id: recipe.to_param, recipe: invalid_attributes, session: valid_session
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "re-renders the 'edit' template" do
        recipe = Recipe.new valid_attributes
        recipe.categories.push cat1
        recipe.save!
				put :update, id: recipe.to_param, recipe: {name: nil}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recipe" do
			recipe = Recipe.new valid_attributes
      recipe.categories.push cat1
      recipe.save!
      expect {
        delete :destroy, id: recipe.to_param, session: valid_session
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
			recipe = Recipe.new valid_attributes
      recipe.categories.push cat1
      recipe.save!
      delete :destroy, id: recipe.to_param, session: valid_session
      expect(response).to redirect_to(recipes_url)
    end
  end

end
