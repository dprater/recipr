class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :edit]

  def index
    @recipes = Recipe.random_recipes(3)
  end

  def search
    term = params[:query]
    @result = Recipe.where("name LIKE #{ActiveRecord::Base.sanitize("%#{term}%")}")
                    .select(:id, :name)
                    .map { |x| { val: x.id, label: x.name } }
    render json: @result
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @category = Category.where(name: recipe_params[:category_name]).first
    @recipe.categories.push @category if @category

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.where(name: recipe_params[:category_name]).first
    @recipe.categories.push @category if @category && !@recipe.categories.include?(@category)
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def get_categories
      @categories = Category.pluck(:name).uniq
    end

    def recipe_params
      params.require(:recipe)
            .permit(:name, :description, :instructions, :image, :category_name,
                    ingredients_attributes: [ :id, :name, :quantity, :unit_of_measurement, :_destroy ])
    end
end
