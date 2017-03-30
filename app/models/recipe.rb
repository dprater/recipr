require_relative '../uploaders/recipe_image_uploader'

class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :categories

  mount_uploader :image, RecipeImageUploader

  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |i| i[:name].blank? }, :allow_destroy => true

  attr_accessor :category_name

  validates_presence_of :name, :description, :instructions
  validate :has_category?

  def has_category?
    errors.add :base, "Recipe must be associated with a category." if self.categories.blank?
  end

  def self.random_recipes(cnt = 3)
    self.limit(cnt).offset(rand(self.count - (cnt - 1)))
  end
end
